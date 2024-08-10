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
            Navigator.pop(
                context); // This will navigate back to the previous screen
          },
        ),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  VideoControls(controller: _controller),
                ],
              )
            : CircularProgressIndicator(),
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
