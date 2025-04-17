import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrNotifier with ChangeNotifier {
  MobileScannerController? _scannerController;
  String? _scannedQrData;

  get getScannerController => _scannerController;
  get getScannedQrData => _scannedQrData;

  set setScannerController(MobileScannerController controller) {
    _scannerController = controller;
  }
  
  set setScannedQrData(String data) {
    _scannedQrData = data;
  }
}