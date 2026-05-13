import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:async';

class FaceVerificationScreen extends StatefulWidget {
  @override
  _FaceVerificationScreenState createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> {
  CameraController? _controller;
  FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(enableClassification: true),
  );
  int blinkCount = 0;
  bool isVerifying = false;
  Timer? _timer;
  int _secondsRemaining = 5;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.medium);
    await _controller!.initialize();
    _startBlinkDetection();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
        if (blinkCount < 2) _showFailure();
      }
    });
  }

  void _startBlinkDetection() {
    _controller!.startImageStream((image) async {
      if (isVerifying) return;
      // ML Kit Processing Logic here...
      // If (face.leftEyeOpenProbability < 0.4 && face.rightEyeOpenProbability < 0.4)
      // blinkCount++;
      if (blinkCount >= 2) {
        _timer?.cancel();
        Navigator.pushReplacementNamed(context, '/kyc');
      }
    });
  }

  void _showFailure() {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text("Verification Failed"),
      content: Text("Please blink twice within 5 seconds."),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Retry"))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Face Verification")),
      body: Column(
        children: [
          if (_controller != null) CameraPreview(_controller!),
          Text("Blinks: $blinkCount/2"),
          Text("Time Left: $_secondsRemaining s"),
        ],
      ),
    );
  }
}
