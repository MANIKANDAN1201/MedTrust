import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPharmaScreen extends StatefulWidget {
  @override
  _SearchPharmaScreenState createState() => _SearchPharmaScreenState();
}

class _SearchPharmaScreenState extends State<SearchPharmaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Pharma'),
        backgroundColor: const Color(0xFF17395E),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pharmacy_verifications')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pharmacies found.'));
          }

          final pharmacies = snapshot.data!.docs;

          return ListView.builder(
            itemCount: pharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = pharmacies[index].data() as Map<String, dynamic>;
              final pharmacyName =
                  pharmacy['pharmacyName'] ?? 'Unknown Pharmacy';
              final isVerified = pharmacy.containsKey('verified')
                  ? pharmacy['verified']
                  : false;
              final location = pharmacy['location'] ?? 'Location not provided';
              final flatNo = pharmacy['flatNo'] ?? 'N/A';
              final landmark = pharmacy['landmark'] ?? 'N/A';
              final directions = pharmacy['directions'] ?? 'N/A';
              final city = pharmacy['city'] ?? 'N/A';
              final pincode = pharmacy['pincode'] ?? 'N/A';
              final ownerName = pharmacy['ownerName'] ?? 'N/A';
              final phoneNumber = pharmacy['phoneNumber'] ?? 'N/A';
              final aadharNumber = pharmacy['aadharNumber'] ?? 'N/A';

              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pharmacyName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isVerified)
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.blue),
                                SizedBox(width: 5),
                                Text('MedTrusted',
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Location: $location'),
                      SizedBox(height: 5),
                      Text('Flat No: $flatNo'),
                      SizedBox(height: 5),
                      Text('Landmark: $landmark'),
                      SizedBox(height: 5),
                      Text('Directions: $directions'),
                      SizedBox(height: 5),
                      Text('City: $city'),
                      SizedBox(height: 5),
                      Text('Pincode: $pincode'),
                      SizedBox(height: 5),
                      Text('Owner Name: $ownerName'),
                      SizedBox(height: 5),
                      Text('Phone Number: $phoneNumber'),
                      SizedBox(height: 5),
                      Text('Aadhar Number: $aadharNumber'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
