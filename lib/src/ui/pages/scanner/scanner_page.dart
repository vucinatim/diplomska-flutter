import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/ui/pages/pages.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  iconSize: 50,
                  icon: FutureBuilder<bool?>(
                    future: controller?.getFlashStatus(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                      if (snapshot.data == false) {
                        return const Icon(Icons.flash_on,
                            color: Colors.white60);
                      } else {
                        return const Icon(Icons.flash_off,
                            color: Colors.white60);
                      }
                    },
                  ),
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                ),
                IconButton(
                  iconSize: 50,
                  icon: FutureBuilder<CameraFacing?>(
                    future: controller?.getCameraInfo(),
                    builder: (BuildContext context,
                        AsyncSnapshot<CameraFacing?> snapshot) {
                      if (snapshot.data == CameraFacing.front) {
                        return const Icon(Icons.camera_front,
                            color: Colors.white60);
                      } else {
                        return const Icon(Icons.camera_rear,
                            color: Colors.white60);
                      }
                    },
                  ),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 150),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black54,
              ),
              child: Text(
                result != null
                    ? 'This is not a Web Menu QR code: \n "${result!.code}"'
                    : 'Scan the QR code',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    final double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode scanData) {
      if (scanData.code.contains('webmenu.si/restaurant/')) {
        controller.stopCamera();
        final String id = scanData.code.split('/').last;
        Navigator.of(context).pushReplacementNamed(AppRouter.RestaurantRoute,
            arguments: RestaurantArguments(id));
      } else {
        setState(() {
          result = scanData;
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
