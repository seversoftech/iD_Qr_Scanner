import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constant/colors.dart';
import '../constant/style.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const ResultScreen(
      {super.key, required this.code, required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            closeScreen();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: black87,
          ),
        ),
        title: const Text('QR Scanner'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImageView(
                data: '',
                size: 150,
                version: QrVersions.auto,
              ),
              Text("Scanned Result", style: style2),
              const SizedBox(height: 10),
              Text(code, style: style1),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 48,
                child: ElevatedButton(
                    onPressed: (() {
                      Clipboard.setData(ClipboardData(text: code));
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      'Copy',
                      style: style2,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
