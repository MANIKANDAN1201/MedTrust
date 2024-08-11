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
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isVerified ? 'Verified' : 'Get Verified',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
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
                child: const Text('Get Verified'),
              ),
          ],
        ),
      ),
    );
  }
}
