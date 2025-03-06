import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/QrCode/CountingBottle.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final List<String> validESPIds = ["ESP1", "ESP2", "ESP3"];
  String? errorMessage;
  bool _hasScanned = false; // Prevent multiple scans

  void _onQRViewScanned(String code) {
    if (_hasScanned) return; // Prevent multiple scans

    if (validESPIds.contains(code)) {
      _hasScanned = true; // Mark as scanned
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountingBottle(result: code),
        ),
      ).then((_) {
        // Reset flag when returning to the scanner screen
        setState(() {
          _hasScanned = false;
        });
      });
    } else {
      setState(() {
        errorMessage = "Invalid QR Code. Please scan an ESP QR code.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code")),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (barcode) {
                if (barcode.barcodes.isNotEmpty) {
                  final String code = barcode.barcodes.first.rawValue ?? "";
                  _onQRViewScanned(code);
                }
              },
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}