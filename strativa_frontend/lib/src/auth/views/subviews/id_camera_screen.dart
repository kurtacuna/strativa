import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class CameraOpeningScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const CameraOpeningScreen({super.key, required this.userData});

  @override
  State<CameraOpeningScreen> createState() => _CameraOpeningScreenState();
}

class _CameraOpeningScreenState extends State<CameraOpeningScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      setState(() {});
    } catch (e) {
      debugPrint("Camera initialization failed: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      // Do something with image.path (e.g., upload or save)
      context.push(AppRoutes.kFaceVerification);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Opening your Camera...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  _initializeControllerFuture != null
                      ? FutureBuilder(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CameraPreview(_controller!),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error loading camera'));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),

            const SizedBox(height: 25),
            const Text(
              "Make sure your government-issued ID is clear and readable; otherwise, it will be considered invalid.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            AppButtonWidget(text: 'Take Picture', onTap: _takePicture),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
