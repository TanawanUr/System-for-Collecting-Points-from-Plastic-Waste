import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/QrCode/CountingBottle.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/navbar.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}


class _QRScannerPageState extends State<QRScannerPage> {
   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller; // Controller can be null

  @override
  void reassemble() {
    super.reassemble();
    // controller?.resumeCamera(); // Safely resume the camera if controller is not null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // QRView(
          //   key: qrKey,
          //   onQRViewCreated: _onQRViewCreated,
          //   overlay: QrScannerOverlayShape(
          //     borderColor: Colors.red,
          //     borderRadius: 10,
          //     borderLength: 30,
          //     borderWidth: 10,
          //     cutOutSize: MediaQuery.of(context).size.width * 0.8,
          //   ),
          // ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     // Debug log for scanned QR code
  //     print("Scanned QR Code: ${scanData.code}");

  //     // Navigate to the result page automatically when a QR code is scanned
  //     // No additional flags are needed here
  //     controller.pauseCamera(); // Stop the camera to prevent rapid scans
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => CountingBottle(result: scanData.code ?? ''),
  //       ),
  //     ).then((_) {
  //       // Resume the camera after returning to the scanner
  //       controller.resumeCamera();
  //     });
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose(); // Dispose of the controller safely
    super.dispose();
  }
}