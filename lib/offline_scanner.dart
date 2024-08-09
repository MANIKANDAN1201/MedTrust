import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert';

import 'scan_result_screen.dart'; // Import the result screen

class OfflineScannerScreen extends StatefulWidget {
  const OfflineScannerScreen({Key? key}) : super(key: key);

  @override
  _OfflineScannerScreenState createState() => _OfflineScannerScreenState();
}

class _OfflineScannerScreenState extends State<OfflineScannerScreen> {
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

        await _checkMedicineInJsonFiles(_barcode);
      }
    } catch (e) {
      setState(() {
        _scanResult = 'Error: $e';
      });
    }
  }

  Future<void> _checkMedicineInJsonFiles(String barcode) async {
    bool found = false;

    try {
      final String jsonString =
          await rootBundle.loadString('assets/medicines.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

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
    } catch (e) {
      setState(() {
        _scanResult = 'Error reading medicines.json: $e';
        _isFake = true;
      });
    }

    if (!found) {
      try {
        final String jsonString =
            await rootBundle.loadString('assets/Medicines_info.json');
        final List<dynamic> jsonData = jsonDecode(jsonString);

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
      } catch (e) {
        setState(() {
          _scanResult = 'Error reading Medicines_info.json: $e';
          _isFake = true;
        });
      }

      if (!found) {
        setState(() {
          _scanResult = "Medicine not found. It might be fake.";
          _isFake = true;
        });
      }
    }
    _navigateToResultScreen();
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
        title: Text('Offline Barcode Scanner'),
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
