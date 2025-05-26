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

class _CameraOpeningScreenState extends State<CameraOpeningScreen> with WidgetsBindingObserver{
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        debugPrint("No available cameras found!");
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(frontCamera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller!.initialize(); // Assign first

      await _initializeControllerFuture; // Now await the initialization

      if (mounted) {
        setState(() {}); // Make sure we only rebuild if mounted
      }
    } catch (e) {
      debugPrint("Camera initialization failed: $e");
    }
  }


  Future<void> _disposeCameraSafely() async {
    await Future.delayed(Duration(milliseconds: 300)); // Short delay
    if (_controller != null && _controller!.value.isInitialized) {
      _controller!.dispose();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_controller != null) {
      if (_controller!.value.isInitialized) {
        try {
          _disposeCameraSafely();
        } catch (e) {
          debugPrint("Error disposing camera controller: $e");
        }
      }
    }
    super.dispose();
  }



  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      final updatedUserData = {
        ...widget.userData,
        'id_image_path': image.path,
      };

      // 🟨 Debug output
      print('--- Captured ID Image and User Data ---');
      updatedUserData.forEach((key, value) {
        print('$key: $value');
      });
      print('----------------------------------------');

      context.push(AppRoutes.kFaceVerification, extra: updatedUserData);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error capturing image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: SafeArea(
        child: Padding(
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
                child: _initializeControllerFuture != null
                    ? FutureBuilder(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && _controller != null) {
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
      ),
    );
  }
}
