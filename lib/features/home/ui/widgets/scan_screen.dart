import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Scan QR Code',
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(
      //         Icons.qr_code_scanner_rounded,
      //         size: 120,
      //         color: Colors.blue,
      //       ),
      //       SizedBox(height: 20),
      //       Text(
      //         'QR Scanner',
      //         style: TextStyle(
      //           fontSize: 22,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //       Text(
      //         'Camera scanner implementation goes here.',
      //         textAlign: TextAlign.center,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}