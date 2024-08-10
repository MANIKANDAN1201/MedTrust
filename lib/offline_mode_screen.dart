import 'package:fakemedicine/barcode_scanner_screen.dart';
import 'package:fakemedicine/basic_procedure.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fakemedicine/offline_scanner.dart';

class OfflineModeScreen extends StatefulWidget {
  @override
  _OfflineModeScreenState createState() => _OfflineModeScreenState();
}

class _OfflineModeScreenState extends State<OfflineModeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/offline.mp4')
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown after initialization
        _controller.play();
        _controller.setLooping(true); // Loop the video
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Modes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F3F3), Color(0xFFDFE0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Align the icon to the top of the screen
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0), // Optional: add some top padding
                  child: Icon(
                    Icons.signal_wifi_off,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20), // Add space between the icon and title
              Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Please check your connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Add video player wrapped with GestureDetector
              GestureDetector(
                onTap: () {
                  // Navigate to OfflineScannerScreen when the video is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfflineScannerScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 230, // Adjust height as needed
                  child: VideoPlayer(_controller),
                ),
              ),
              SizedBox(height: 30),
              // New description text
              Text(
                'You are currently offline and are restricted. However, you can use our app\'s offline features while you return online.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BasicProcedures(),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/procedure.png',
                    fit: BoxFit.contain,
                    height: 190,
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
