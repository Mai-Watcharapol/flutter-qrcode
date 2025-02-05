import 'package:flutter/material.dart';
import 'qr_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final QRScannerManager qrManager = QRScannerManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanning QR Code"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            qrManager.controller?.dispose();
            Navigator.pop(context);
          },
        ),
      ),
      body: qrManager.buildQRView(context, (data) {
        qrManager.dispose();
        Navigator.pop(context, data);
      }),
    );
  }
}