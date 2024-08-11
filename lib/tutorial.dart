import 'package:fakemedicine/barcode_scanner_screen.dart';
import 'package:fakemedicine/basic_procedure.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  late VideoPlayerController _controller;
  late VideoPlayerValue _value;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/FAKE.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });

    _controller.addListener(() {
      if (!_isDragging) {
        setState(() {
          _value = _controller.value;
        });
      }
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
        title: Text('Tutorial'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: const Color(0xFF17395E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Add padding around the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Learn How to Use Our App',
              style: TextStyle(
                fontSize: 24, // Heading font size
                fontWeight: FontWeight.bold, // Bold text
                color: const Color(0xFF17395E), // Text color
              ),
              textAlign: TextAlign.center, // Center align text
            ),
            const SizedBox(height: 20), // Space between heading and video
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Curved corners
                border: Border.all(
                  color: Colors.lightBlue, // Light blue border
                  width: 2, // Border width
                ),
              ),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    20), // Ensure video has curved corners
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(
                        height: 250,
                        color: Colors.black12,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            VideoControls(controller: _controller),
            const SizedBox(
                height: 20), // Space between video and additional content
            Text(
              'Some Additional Necessities',
              style: TextStyle(
                fontSize: 18, // Text font size
                fontWeight: FontWeight.bold, // Bold text
                color: const Color(0xFF17395E), // Text color
              ),
              textAlign: TextAlign.center, // Center align text
            ),
            const SizedBox(height: 10), // Space between text and image
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
    );
  }
}

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;

  VideoControls({required this.controller});

  @override
  _VideoControlsState createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  late VideoPlayerController _controller;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                setState(() {
                  _controller.seekTo(Duration.zero);
                  _controller.pause();
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 5), // Reduced space between controls
        Slider(
          value: _isDragging
              ? _controller.value.position.inSeconds.toDouble()
              : _controller.value.position.inSeconds.toDouble(),
          min: 0.0,
          max: _controller.value.duration.inSeconds.toDouble(),
          onChanged: (value) {
            setState(() {
              _isDragging = true;
            });
            _controller.seekTo(Duration(seconds: value.toInt()));
          },
          onChangeEnd: (value) {
            setState(() {
              _isDragging = false;
            });
          },
          activeColor: Colors.blue, // Slider color
          inactiveColor: Colors.grey, // Slider color
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.volume_down),
              onPressed: () {
                setState(() {
                  _controller.setVolume(
                    (_controller.value.volume - 0.1).clamp(0.0, 1.0),
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () {
                setState(() {
                  _controller.setVolume(
                    (_controller.value.volume + 0.1).clamp(0.0, 1.0),
                  );
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
