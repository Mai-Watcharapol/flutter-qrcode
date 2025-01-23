import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerManager {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  Barcode? _result;
  bool _isListening = false;


  QRScannerManager() {
    // if (!Platform.isAndroid) {
    //   pause();
    // } else {
    //   resume();
    // }
  }

  void startScanning(Function(String) onCodeScanned) {
    if (!_isListening) {
      _controller?.scannedDataStream.listen((scanData) {
        if (scanData.code != null) {
          _result = scanData;
          onCodeScanned(scanData.code!); // เรียกฟังก์ชันเมื่อสแกนสำเร็จ
        }
      });
      _isListening = true;
    }
  }

  // เริ่มต้นการทำงานของ QR Scanner
  void onQRViewCreated(QRViewController controller, Function(String) onCodeScanned) {
    _controller = controller;
    startScanning(onCodeScanned); // เริ่มการสแกนเมื่อสร้าง QRView
  }


  void dispose() {
    _controller?.dispose();
  }


  void pause() {
    _controller?.pauseCamera();
  }


  void resume() {
    _controller?.resumeCamera();
  }

  // สร้าง QRView
  Widget buildQRView(BuildContext context, Function(String) onCodeScanned) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        onQRViewCreated(controller, onCodeScanned);
      },
    );
  }

}
