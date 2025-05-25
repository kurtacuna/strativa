import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class FaceScanCameraScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FaceScanCameraScreen({super.key, required this.userData});

  @override
  State<FaceScanCameraScreen> createState() => _FaceScanCameraScreenState();
}

class _FaceScanCameraScreenState extends State<FaceScanCameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  String? capturedImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(frontCamera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error initializing front camera: $e');
    }
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

      if (!mounted) return;

      setState(() {
        capturedImagePath = image.path;
      });

      // 🟨 Debug output
      print('--- Captured Selfie Image ---');
      print('Image path: $capturedImagePath');
      print('-----------------------------');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selfie captured successfully!')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to capture image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Face Scan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Expanded(
            child:
                _initializeControllerFuture != null
                    ? FutureBuilder(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CameraPreview(_controller!),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error loading camera'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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
              if (capturedImagePath != null) {
                final updatedUserData = {
                  ...widget.userData,
                  'selfie_image_path': capturedImagePath,
                  // Ensure id_image_path is preserved if it exists
                  'id_image_path': widget.userData['id_image_path'],
                };

                // 🟨 Debug output
                print('--- Proceeding with User Data ---');
                updatedUserData.forEach((key, value) {
                  print('$key: $value');
                });
                print('----------------------------------');

                context.push(AppRoutes.kGenderMarital, extra: updatedUserData);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please capture a selfie first!'),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
