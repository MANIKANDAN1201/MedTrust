import 'package:flutter/material.dart';

class NearbyPharmacyScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const NearbyPharmacyScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the latitude and longitude to find nearby pharmacies
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Pharmacies'),
      ),
      body: Center(
        child: Text(
          'Displaying pharmacies near: Latitude: $latitude, Longitude: $longitude',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
