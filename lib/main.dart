import 'payment_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'auth_screen.dart';
import 'auth_screen_pharma.dart';
import 'home_screen.dart';
import 'home_pharma.dart';
import 'offline_mode_screen.dart';
import 'splash_screen.dart'; // Import the new splash_screen.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnectivityChecker(),
      routes: {
        '/auth': (context) => AuthScreen(),
        '/auth_pharma': (context) => AuthScreenPharma(),
        '/home': (context) => HomeScreen(),
        '/home_pharma': (context) => HomePharmaScreen(),
        '/offline': (context) => OfflineModeScreen(),
        '/payment': (context) => PaymentPage(pharmacyId: '123'),
      },
    );
  }
}

class ConnectivityChecker extends StatefulWidget {
  @override
  _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.of(context).pushReplacementNamed('/offline');
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthStateHandler(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class AuthStateHandler extends StatelessWidget {
  Future<String?> _getUserChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return SplashScreen();
        } else {
          return FutureBuilder<String?>(
            future: _getUserChoice(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data == 'pharma') {
                  return HomePharmaScreen();
                } else {
                  return HomeScreen();
                }
              } else {
                return SplashScreen();
              }
            },
          );
        }
      },
    );
  }
}
