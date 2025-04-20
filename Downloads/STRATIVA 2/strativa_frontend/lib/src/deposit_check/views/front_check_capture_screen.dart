import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'back_check_capture_screen.dart';
import 'package:strativa_frontend/src/deposit_check/controllers/image_cropper_service.dart';

class FrontCheckCaptureScreen extends StatefulWidget {
  const FrontCheckCaptureScreen({super.key});

  @override
  State<FrontCheckCaptureScreen> createState() => _FrontCheckCaptureScreenState();
}

class _FrontCheckCaptureScreenState extends State<FrontCheckCaptureScreen> {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  File? _capturedImage;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    await _controller.initialize();
    await _controller.setFlashMode(FlashMode.off); // Default to OFF
    if (mounted) {
      setState(() => _isCameraInitialized = true);
    }
  }

  Future<void> _capturePhoto() async {
    final image = await _controller.takePicture();

    // Crop the image using the service
    final cropped = await ImageCropperService.cropImage(image.path, 'front');

    if (cropped != null) {
      setState(() => _capturedImage = cropped);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: _capturedImage == null
          ? Stack(
              children: [
                CameraPreview(_controller),
                // Flash toggle button
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () async {
                      setState(() => _isFlashOn = !_isFlashOn);
                      await _controller.setFlashMode(
                        _isFlashOn ? FlashMode.torch : FlashMode.off,
                      );
                    },
                  ),
                ),
                // Capture button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: FloatingActionButton(
                      onPressed: _capturePhoto,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.camera, color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.file(_capturedImage!),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _capturedImage = null),
                      child: const Text("Retake"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BackCheckCaptureScreen(frontImage: _capturedImage!),
                          ),
                        );
                      },
                      child: const Text("Use This"),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
