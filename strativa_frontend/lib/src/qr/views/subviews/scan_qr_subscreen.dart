import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/debouncer.dart';
import 'package:strativa_frontend/common/widgets/app_snack_bar_widget.dart';
import 'package:strativa_frontend/src/qr/controllers/scan_qr_notifier.dart';
import 'package:strativa_frontend/src/qr/widgets/no_camera_permission_widget.dart';

class ScanQrSubScreen extends StatefulWidget {
  const ScanQrSubScreen({super.key});

  @override
  State<ScanQrSubScreen> createState() => _ScanQrSubScreenState();
}

class _ScanQrSubScreenState extends State<ScanQrSubScreen> {
  late final MobileScannerController _scannerController = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    detectionTimeoutMs: 500,
  );
  final Debouncer _debouncer = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    _scannerController.start();

    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();

    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset(0, -150.h)),
      width: 300,
      height: 300,
    );

    return Consumer<ScanQrNotifier>(
      builder: (context, scanQrNotifier, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              onDetect: (captured) {
                _debouncer.run(() {
                  List<Barcode> barcodes = captured.barcodes;
                  String scannedQrData = barcodes[0].rawValue ?? "";

                  if (scannedQrData.isNotEmpty) {
                    scanQrNotifier.setScannedQrData = scannedQrData;
                    scanQrNotifier.setScannerController = _scannerController;
                    _scannerController.stop();
                    context.push(AppRoutes.kScannedQrSubscreen);
                  }
                });
              },
              scanWindow: scanWindow,
              controller: _scannerController,
              overlayBuilder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: CustomPaint(
                    painter: ScannerOverlay(scanWindow: scanWindow),
                  ),
                );
              },
              errorBuilder: (context, mobileScannerException, child) {
                if (mobileScannerException.errorCode == MobileScannerErrorCode.permissionDenied) {
                  return NoCameraPermissionWidget();
                }
                    
                return Center(
                  child: Padding(
                    padding: AppConstants.kAppPadding,
                    child: Text(
                      "An unexpected error occurred: ${mobileScannerException.errorCode}",
                      style: CustomTextStyles(context).defaultStyle
                    ),
                  )
                );
              },
            ),
            
            // Upload QR Button
            Positioned(
              child: Align(
                alignment: Alignment(0, 0.9),
                child: ElevatedButton(
                  onPressed: () async {
                    final XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery
                    );

                    if (pickedFile != null) {
                      BarcodeCapture? captured = await MobileScannerPlatform.instance.analyzeImage(pickedFile.path);
                      
                      if (captured != null) {
                        List<Barcode> barcodes = captured.barcodes;
                        String? scannedQrData = barcodes[0].rawValue;
                        
                        if (scannedQrData != null) {
                          if (context.mounted) {
                            scanQrNotifier.setScannedQrData = scannedQrData;
                            scanQrNotifier.setScannerController = _scannerController;
                            _scannerController.stop();
                            context.push(AppRoutes.kScannedQrSubscreen);
                          }
                        }
                        
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            appSnackBarWidget(
                              context: context, 
                              text: AppText.kNoQrCodeFound,
                              icon: AppIcons.kErrorIcon
                            )
                          );
                        }
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          appSnackBarWidget(
                            context: context, 
                            text: AppText.kImageCouldntBeScanned,
                            icon: AppIcons.kErrorIcon
                          )
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      ColorsCommon.kAccentL3
                    ),
                    overlayColor: WidgetStatePropertyAll(
                      ColorsCommon.kDarkerGray.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    AppText.kUploadQrCode,
                    style: CustomTextStyles(context).defaultStyle.copyWith(
                      color: ColorsCommon.kWhite,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ]
        );
      }
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 10,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path();
    backgroundPath.addRect(
      Rect.fromLTWH(0, 0, size.width, size.height)
    );

    final cutoutPath = Path();
    cutoutPath.addRRect(
      RRect.fromRectAndCorners(
        scanWindow,
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      )
    );

    final backgroundPaint = Paint();
    backgroundPaint.color = ColorsCommon.kDark.withValues(alpha: 0.4);
    backgroundPaint.style = PaintingStyle.fill;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint();
    borderPaint.color = ColorsCommon.kWhite;
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 4;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow || borderRadius != oldDelegate.borderRadius;
  }
}