import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'barcode_scanner_screen.dart';
import 'notifications.dart';
import 'report_screen.dart';
import 'profile_screen.dart';
import 'medicine_details_page.dart';
import 'health_vitals_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final TextEditingController _serialNumberController = TextEditingController();
  String _barcode = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    NotificationsScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Change page in PageView

    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        // Navigate to Barcode Scanner Page if not already there
        if (_pageController.page != 0) {
          _pageController.jumpToPage(0);
        }
        break;
      case 1:
        // Navigate to Notifications Page if not already there
        if (_pageController.page != 1) {
          _pageController.jumpToPage(1);
        }
        break;
      case 2:
        // Navigate to Report Page if not already there
        if (_pageController.page != 2) {
          _pageController.jumpToPage(2);
        }
        break;
      case 3:
        // Navigate to Profile Page within the PageView
        _pageController.jumpToPage(3);
        break;
    }
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
            color:
                isSelected ? Colors.white : Colors.black, // Change icon color
            size: 24.0,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? Colors.white : Colors.black, // Change text color
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Inside the Scaffold of HomeScreen

      appBar: AppBar(
        backgroundColor: Color(0xFF17395E), // Set background color to #17395E
        iconTheme:
            IconThemeData(color: Colors.white), // Change drawer icon to white
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services,
              size: 28,
              color: Colors.white, // Icon color set to white
            ),
            SizedBox(width: 8), // Space between the icon and the text
            Text(
              'MEDTRUST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white, // Text color set to white
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,
                color: Colors.white), // Icon color set to white
            onPressed: () {
              _onItemTapped(1);
            },
          ),
          IconButton(
            icon: Icon(Icons.person,
                color: Colors.white), // Icon color set to white
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF17395E), // Changed color to #17395E
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Color(0xFF17395E)), // Icon color set to #17395E
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications,
                  color: Color(0xFF17395E)), // Icon color set to #17395E
              title: Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.report,
                  color: Color(0xFF17395E)), // Icon color set to #17395E
              title: Text('Report'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.person,
                  color: Color(0xFF17395E)), // Icon color set to #17395E
              title: Text('Account'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout,
                  color: Color(0xFF17395E)), // Icon color set to #17395E
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/auth');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey, Colors.white], // Corrected gradient colors
          ),
        ),
        child: PageView(
          controller: _pageController,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search bar
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search for Medicine',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MedicineDetailsPage(medicineName: value),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  // Serial number input horizontal card

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarcodeScannerScreen(),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius for the curve
                      child: Image.asset(
                        'assets/scan.png',
                        fit: BoxFit
                            .contain, // Ensures image covers available space
                        width:
                            0, // Stretches the image to the width of the page
                        height:
                            190, // Set a specific height or adjust as needed
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Feature cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Health Vitals horizontal card
                      // Replace the green container with the Health Vitals icon and text
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HealthVitalsScreen(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15), // Optional: Add rounded corners
                            child: Image.asset(
                              'assets/image.png', // Replace with your actual asset path
                              fit: BoxFit
                                  .cover, // Adjust this based on how you want the image to fit
                              height: 150, // Adjust the height as necessary
                              width: double
                                  .infinity, // Ensures the image stretches the full width
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReportScreen(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15), // Optional: Add rounded corners
                            child: Image.asset(
                              'assets/image2.png', // Replace with your actual asset path
                              fit: BoxFit
                                  .cover, // Adjust this based on how you want the image to fit
                              height: 150, // Adjust the height as necessary
                              width: double
                                  .infinity, // Ensures the image stretches the full width
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            NotificationsScreen(),
            ReportScreen(),
            ProfileScreen(), // Ensure ProfileScreen is part of the PageView
          ],
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF17395E), // Set BottomAppBar color to #17395E
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 45.0, // Reduced height
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.notifications, 'Notifications', 1),
              const SizedBox(
                  width: 30), // Reduced gap for the floating action button
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
          color: Colors.white, // Sets the icon color to white
        ),
        elevation: 2.0,
        shape: CircleBorder(), // Ensures the button is perfectly round
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 36, color: Colors.white),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: HomeScreen(),
    ));
