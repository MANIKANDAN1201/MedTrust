import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'report_screen.dart'; // Import ReportScreen

class ScanResultScreen extends StatelessWidget {
  final String barcode;
  final String scanResult;
  final String expiryDate;
  final bool isFake;
  final String medicineName;
  final String manufacturerName;

  const ScanResultScreen({
    Key? key,
    required this.barcode,
    required this.scanResult,
    required this.expiryDate,
    required this.isFake,
    required this.medicineName,
    required this.manufacturerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
        backgroundColor:
            isFake ? Colors.red : Colors.green, // Conditional color
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Display tick or X based on the result
              Center(
                child: Lottie.asset(
                  isFake
                      ? 'assets/no.json'
                      : 'assets/tick.json', // Use Lottie assets
                  width: 100, // Adjust size if needed
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
              // Barcode Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Barcode:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        barcode,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Medicine Info Card (only shown if the medicine is not fake)
              if (!isFake) ...[
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medicine Name:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          medicineName,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Manufacturer Name:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          manufacturerName,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
              // Scan Result Card
              Card(
                color: isFake ? Colors.red[100] : Colors.green[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      scanResult,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isFake ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              if (isFake) ...[
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'This medicine is fake. Please report it.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Conditional Report Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportScreen(),
                        ),
                      );
                    },
                    child: Text('Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF33E4DB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Scan Another'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF33E4DB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
