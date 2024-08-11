import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_pharma.dart';

class PaymentPage extends StatefulWidget {
  final String pharmacyId;

  PaymentPage({required this.pharmacyId});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isVerified = false;

  Future<void> _verifyPharmacy() async {
    // Update the verified status in Firestore
    await FirebaseFirestore.instance
        .collection('pharmacy_verifications')
        .doc(widget.pharmacyId)
        .update({'verified': true});

    setState(() {
      isVerified = true;
    });

    // Optionally show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful! You are now verified.'),
      ),
    );

    // Navigate back to HomePharmaScreen after verification
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePharmaScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: const Color(0xFF17395E),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: isVerified ? null : _verifyPharmacy,
          child: Text(isVerified ? 'Verified' : 'Click to Verify'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF17395E),
          ),
        ),
      ),
    );
  }
}
