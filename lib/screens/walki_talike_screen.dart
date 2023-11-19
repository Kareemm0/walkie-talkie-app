import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WalkieTalkieScreen extends StatefulWidget {
  const WalkieTalkieScreen({super.key});

  @override
  _WalkieTalkieScreenState createState() => _WalkieTalkieScreenState();
}

class _WalkieTalkieScreenState extends State<WalkieTalkieScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleAudio() {
    if (_isPlaying) {
      _audioPlayer.stop();
    } else {
      _audioPlayer.play(UrlSource("assets/audio/"));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walkie-Talkie'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isPlaying ? 'Listening...' : 'Press and hold to talk',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onLongPress: _toggleAudio,
              onLongPressUp: _toggleAudio,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: _isPlaying ? Colors.red : Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mic,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
