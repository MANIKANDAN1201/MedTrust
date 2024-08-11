import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'get_verified.dart';

class VerificationCard extends StatefulWidget {
  final String pharmacyId;

  const VerificationCard({required this.pharmacyId});

  @override
  _VerificationCardState createState() => _VerificationCardState();
}

class _VerificationCardState extends State<VerificationCard> {
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    final doc = await FirebaseFirestore.instance
        .collection('pharmacy_verifications')
        .doc(widget.pharmacyId)
        .get();

    if (doc.exists) {
      final data = doc.data();
      final bool isVerified = data != null &&
          data.containsKey('verified') &&
          data['verified'] == true;
      setState(() {
        _isVerified = isVerified;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _isVerified ? Icons.verified : Icons.verified_outlined,
              size: 60,
              color: _isVerified ? Colors.green : Colors.red,
            ),
            SizedBox(height: 10),
            Text(
              _isVerified ? 'Verified Pharmacy' : 'Get Your Pharmacy Verified',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _isVerified ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              _isVerified
                  ? 'Your pharmacy is verified. Thank you for ensuring trust and authenticity.'
                  : 'Verify your pharmacy to ensure trust and authenticity. This helps us maintain high standards for our customers.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            if (!_isVerified) SizedBox(height: 20),
            if (!_isVerified)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GetVerifiedScreen(pharmacyId: widget.pharmacyId),
                    ),
                  ).then((value) {
                    // Re-check verification status when returning from verification screen
                    _checkVerificationStatus();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF17395E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Get Verified',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
