import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VoiceScreen(),
    );
  }
}

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _recognizedText = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: (status) {
        print('Speech status: $status');
        setState(() {
          _isListening = status == 'listening';
        });
      },
      onError: (error) {
        print('Speech error: $error');
        setState(() {
          _isListening = false;
          _recognizedText = 'Error: $error';
        });
      },
    );
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenMode: ListenMode.dictation,
        cancelOnError: true,
      );
    } else {
      setState(() {
        _recognizedText = 'Speech recognition not available';
      });
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    _speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Assistant', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap the microphone to speak',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _recognizedText.isEmpty
                    ? 'No text recognized yet...'
                    : _recognizedText,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            if (!_speechEnabled)
              const Text(
                'Speech recognition is not available on this device.',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: _isListening ? _stopListening : _startListening,
          backgroundColor: _isListening ? Colors.red : Colors.blue,
          child: Icon(
            _isListening ? Icons.mic_off : Icons.mic,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}