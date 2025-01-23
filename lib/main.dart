import 'package:flutter/material.dart';
import 'scanner_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _qrResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Scanner")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_qrResult.isNotEmpty) _buildResultBox(),
            const SizedBox(height: 20),
            _buildScanButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _qrResult,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildScanButton() {
    return ElevatedButton(
      onPressed: () async {
        final result = await Navigator.push<String>(
          context,
          MaterialPageRoute(builder: (context) => const QRScannerPage()),
        );

        if (result != null) {
          setState(() {
            _qrResult = result;
          });
        }
      },
      child: const Text("Scan QR Code"),
    );
  }
}
