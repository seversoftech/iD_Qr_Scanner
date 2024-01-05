import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

import '../constant/colors.dart';
import '../constant/style.dart';
import 'result_screen.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScannedCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScannedCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(
                    () {
                      isFlashOn = !isFlashOn;
                    },
                  );

                  controller.toggleTorch();
                },
                icon: Icon(Icons.flash_on,
                    color: isFlashOn ? primaryColor2 : black54)),
            IconButton(
                onPressed: () {
                  setState(
                    () {
                      isFrontCamera = !isFrontCamera;
                    },
                  );

                  controller.switchCamera();
                },
                icon: Icon(Icons.camera_front,
                    color: isFrontCamera ? primaryColor2 : black54))
          ],
          iconTheme: IconThemeData(color: black54),
          title: const Text("QR Scanner")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Place the QR code in the area", style: style1),
                  Text("Scanning will be started automatically", style: style2)
                ],
              ),
            ),
            // Expanded(flex: 4, child: Container(color: Colors.green)),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScannedCompleted) {
                        String code = barcode.rawValue ?? '----';
                        isScannedCompleted = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              closeScreen: closeScreen,
                              code: code,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColor: white,
                    borderColor: primaryColor2,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: Column(
              children: [
                Text("Developed by Godson Chinatu", style: style3),
                Text("Supervised by Mr. Ogwo Eme", style: style3),
                Text("Verified by Sever Emmanuel", style: style3),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
