import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? value = barcodes.first.rawValue;
    if (value == null || value.isEmpty) return;

    _handled = true;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),
          _buildOverlay(),
          _buildTopBar(context),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Center(
      child: Container(
        width: Responsive.w(260),
        height: Responsive.w(260),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.newPri, width: 2.5),
          borderRadius: BorderRadius.circular(Responsive.w(18)),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(12),
          vertical: Responsive.h(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text(
              'Scan QR / Barcode',
              style: customTextStyle(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, state, child) {
                  final torchOn = state.torchState == TorchState.on;
                  return Icon(
                    torchOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  );
                },
              ),
              onPressed: () => _controller.toggleTorch(),
            ),
          ],
        ),
      ),
    );
  }
}