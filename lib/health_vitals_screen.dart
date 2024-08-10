import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import the screens that you will navigate to
import 'package:fakemedicine/home_screen.dart';
import 'package:fakemedicine/notifications.dart';
import 'package:fakemedicine/report_screen.dart';
import 'package:fakemedicine/profile_screen.dart';
import 'package:fakemedicine/health.dart'; // Import the HealthVitalsScreens page

class HealthVitalsScreen extends StatefulWidget {
  @override
  _HealthVitalsScreenState createState() => _HealthVitalsScreenState();
}

class _HealthVitalsScreenState extends State<HealthVitalsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  String _selectedGender = "";

  var _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF17395E),
        title: Text(
          'Health Vitals',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Select Your Gender',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGenderButton('Male', Icons.male),
                    _buildGenderButton('Female', Icons.female),
                    _buildGenderButton('Other', Icons.transgender),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'How old are you?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _ageController,
                  label: 'Enter your age',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _heightController,
                        label: 'Height (cm)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: _weightController,
                        label: 'Weight (kg)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _bloodTypeController,
                  label: 'Blood Type',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                // Image Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageCard('assets/images/gopal.png', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthVitalsScreens(),
                        ),
                      );
                    }),
                    _buildImageCard('assets/images/image1.png', () {
                      // Handle tap on the second image if needed
                    }),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      saveHealthDetails();
                    }
                  },
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF17395E),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF17395E),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 45.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.notifications, 'Notifications', 1),
              const SizedBox(width: 30),
              _buildNavItem(Icons.report, 'Report', 2),
              _buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF17395E),
        onPressed: () {
          // Add your onPressed code here!
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
        elevation: 2.0,
        shape: CircleBorder(),
      ),
    );
  }

  Widget _buildGenderButton(String gender, IconData icon) {
    return ChoiceChip(
      label: Text(gender),
      avatar: Icon(icon, color: Colors.white),
      selected: _selectedGender == gender,
      onSelected: (bool selected) {
        setState(() {
          _selectedGender = selected ? gender : "";
        });
      },
      selectedColor: Color(0xFF17395E),
      backgroundColor: Colors.blueGrey[100],
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildImageCard(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
            size: 24.0,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        switch (index) {
          case 0:
            return HomeScreen();
          case 1:
            return NotificationsScreen(
              message: 'Your notification message here',
            );
          case 2:
            return ReportScreen();
          case 3:
            return ProfileScreen();
          default:
            return HomeScreen(); // Default to HomeScreen if index is unknown
        }
      }),
    );
  }

  Future<void> saveHealthDetails() async {
    final userHealthData = {
      'age': _ageController.text,
      'height': _heightController.text,
      'weight': _weightController.text,
      'bloodType': _bloodTypeController.text,
      'gender': _selectedGender,
    };

    try {
      await FirebaseFirestore.instance
          .collection('health_vitals')
          .add(userHealthData);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Health data saved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
    }
  }
}
