import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QRScannerManager {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? _controller;

  Barcode? _result;

  bool _isListening = false;

  QRViewController? get controller => _controller;

  String? get getResult => _result?.code;

  QRScannerManager() {
    if (Platform.isAndroid) {
      _controller?.resumeCamera();
    } else {
      _controller?.pauseCamera();
    }
  }

  void startScanning(Function(String) onCodeScanned) {
    _result = null;
    if (!_isListening) {
      _controller?.scannedDataStream.listen((scanData) {
        if (scanData.code != null) {
          _result = scanData;
          onCodeScanned(scanData.code!);
        }
      });
      _isListening = true;
    }
  }

  void onQRViewCreated(QRViewController controller, Function(String) onCodeScanned) {
    _controller = controller;
    startScanning(onCodeScanned);
  }

  void stopScanning() {
    _controller?.dispose();
  }

   Widget buildQRView(BuildContext context, Function(String) onCodeScanned) {
    return QRView(
      key: qrKey,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 250,
      ),
      onQRViewCreated: (controller) {
        onQRViewCreated(controller, onCodeScanned);
      },
    );
  }
}