import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment_page.dart'; // Import the payment page

class GetVerifiedScreen extends StatefulWidget {
  final String pharmacyId;

  GetVerifiedScreen({required this.pharmacyId});

  @override
  _GetVerifiedScreenState createState() => _GetVerifiedScreenState();
}

class _GetVerifiedScreenState extends State<GetVerifiedScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _flatNoController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _aadharNumberController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Save the form data to Firebase
      await FirebaseFirestore.instance
          .collection('pharmacy_verifications')
          .doc(widget.pharmacyId)
          .set({
        'pharmacyName': _pharmacyNameController.text,
        'location': _locationController.text,
        'flatNo': _flatNoController.text,
        'landmark': _landmarkController.text,
        'directions': _directionsController.text,
        'city': _cityController.text,
        'pincode': _pincodeController.text,
        'ownerName': _ownerNameController.text,
        'phoneNumber': _phoneNumberController.text,
        'aadharNumber': _aadharNumberController.text,
        'verified': false, // Initially not verified
      });

      // Navigate to the payment page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(pharmacyId: widget.pharmacyId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Verified'),
        backgroundColor: Color(0xFF17395E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Pharmacy Name
              TextFormField(
                controller: _pharmacyNameController,
                decoration: InputDecoration(
                  labelText: 'Pharmacy Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the pharmacy name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Flat No
              TextFormField(
                controller: _flatNoController,
                decoration: InputDecoration(
                  labelText: 'Flat No',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the flat number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Landmark
              TextFormField(
                controller: _landmarkController,
                decoration: InputDecoration(
                  labelText: 'Landmark',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the landmark';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Directions
              TextFormField(
                controller: _directionsController,
                decoration: InputDecoration(
                  labelText: 'Directions to Reach',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter directions to reach';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // City
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Pincode
              TextFormField(
                controller: _pincodeController,
                decoration: InputDecoration(
                  labelText: 'Pincode',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the pincode';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Owner Name
              TextFormField(
                controller: _ownerNameController,
                decoration: InputDecoration(
                  labelText: 'Owner Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the owner name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Phone Number
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Aadhar Number
              TextFormField(
                controller: _aadharNumberController,
                decoration: InputDecoration(
                  labelText: 'Aadhar Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the aadhar number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Note and Submit Button
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Note: After clicking submit, you will need to pay ₹250 to get verified.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1B3254),
                        ),
                        child: Text('Submit and Proceed to Payment'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
