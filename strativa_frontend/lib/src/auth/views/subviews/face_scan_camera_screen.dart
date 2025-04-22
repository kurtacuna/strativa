import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class FaceScanCameraScreen extends StatefulWidget {
  const FaceScanCameraScreen({super.key});

  @override
  State<FaceScanCameraScreen> createState() => _FaceScanCameraScreenState();
}

class _FaceScanCameraScreenState extends State<FaceScanCameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller!.initialize();
    await _initializeControllerFuture;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takeSelfie() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      // Optionally save or process image.path
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selfie captured: ${image.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Scan')),
      body: Column(
        children: [
          Expanded(
            child: _controller != null &&
                    _controller!.value.isInitialized &&
                    _initializeControllerFuture != null
                ? FutureBuilder(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CameraPreview(_controller!),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 20),
          AppButtonWidget(text: 'Capture', onTap: _takeSelfie),
          const SizedBox(height: 10),
          AppButtonWidget(
            text: 'Next',
            onTap: () {
              context.push(AppRoutes.kGenderMarital);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
