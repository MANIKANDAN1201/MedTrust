import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'scan_result_screen.dart'; // Import the result screen

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _barcode = "";
  String _scanResult = "";
  String _expiryDate = "";
  bool? _isFake;
  String _medicineName = "";
  String _manufacturerName = "";

  Future<void> _scanBarcode() async {
    try {
      setState(() {
        _scanResult = "";
        _expiryDate = "";
        _medicineName = "";
        _manufacturerName = "";
      });

      final result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (result != '-1') {
        setState(() {
          _barcode = result;
        });

        await FirebaseFirestore.instance.collection('barcodes').add({
          'barcode': _barcode,
          'scannedAt': Timestamp.now(),
        });

        await _checkMedicine(_barcode);
      }
    } catch (e) {
      setState(() {
        _scanResult = 'Error: $e';
      });
    }
  }

  Future<void> _checkMedicine(String barcode) async {
    try {
      final url =
          'https://api.upcitemdb.com/prod/trial/lookup?upc=$barcode'; // API URL with the scanned barcode
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['items'] != null && data['items'].isNotEmpty) {
          final product = data['items'][0];
          setState(() {
            _medicineName = product['title'] ?? "Unknown";
            _manufacturerName = product['brand'] ?? "Unknown";
            _expiryDate = "Not Available";
            _isFake = false;
            _scanResult = "This medicine is genuine.";
          });
        } else {
          // If product not found in API, check the local JSON file
          await _checkMedicineInJson(barcode);
        }
      } else {
        // If there's an issue with the API, directly check the JSON file
        await _checkMedicineInJson(barcode);
      }
    } catch (e) {
      // On exception, also check the JSON file
      await _checkMedicineInJson(barcode);
    } finally {
      _navigateToResultScreen();
    }
  }

  Future<void> _checkMedicineInJson(String barcode) async {
    try {
      // Load the JSON file
      final String jsonString =
          await rootBundle.loadString('assets/medicines.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      bool found = false;
      for (var item in jsonData) {
        if (item['Barcode_No'] == barcode) {
          setState(() {
            _medicineName = item['Name'] ?? "Unknown";
            _manufacturerName = item['Manufacturer'] ?? "Unknown";
            _expiryDate = item['Expiry_Date'] ?? "Not Available";
            _isFake = false;
            _scanResult = "This medicine is genuine.";
          });
          found = true;
          break;
        }
      }

      if (!found) {
        setState(() {
          _scanResult = "Medicine not found. It might be fake.";
          _isFake = true;
        });
      }
    } catch (e) {
      setState(() {
        _scanResult = 'Error reading JSON data: $e';
        _isFake = true;
      });
    } finally {
      _navigateToResultScreen();
    }
  }

  void _navigateToResultScreen() {
    if (_scanResult.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResultScreen(
            barcode: _barcode,
            scanResult: _scanResult,
            expiryDate: _expiryDate,
            isFake: _isFake!,
            medicineName: _medicineName,
            manufacturerName: _manufacturerName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _barcode.isEmpty ? 'Scan a barcode' : 'Scanned: $_barcode',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Start Barcode Scan'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _scanResult.isEmpty ? '' : 'Result: $_scanResult',
              style: TextStyle(
                  fontSize: 16,
                  color: _isFake == true ? Colors.red : Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              _expiryDate,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
