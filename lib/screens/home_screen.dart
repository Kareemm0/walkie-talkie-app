import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer audioPlayer;

  late AudioRecorder record;

  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    record = AudioRecorder();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    record.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await record.hasPermission()) {
        await record.start(
          const RecordConfig(),
          path: "assets/audio/",
        );
        setState(() {
          isRecording = true;
        });
      }
    } catch (error) {
      print("Error While Start Recording $error");
    }
  }

  Future<void> playRecord() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (error) {
      print("Error While Playing Record $error");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await record.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (error) {
      print("Error While Stop Recording");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Walkie Talkie",
          style: TextStyle(
            fontSize: 24,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRecording)
              const Text(
                "Recording in progress",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
            ElevatedButton.icon(
              onPressed: isRecording ? stopRecording : startRecording,
              icon: const Icon(Icons.mic),
              label: isRecording
                  ? const Text("Stop Recording")
                  : const Text("Start Recording"),
            ),
            const SizedBox(
              height: 30,
            ),
            if (isRecording)
              ElevatedButton.icon(
                onPressed: playRecord,
                icon: const Icon(Icons.audiotrack),
                label: const Text("Start Audio Player"),
              )
          ],
        ),
      ),
    );
  }
}
