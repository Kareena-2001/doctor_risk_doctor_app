import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecaptchaWidget extends StatefulWidget {
  const RecaptchaWidget({
    super.key,
    required this.siteKey,
    required this.onVerified,
    required this.onExpired,
  });

  final String siteKey;
  final ValueChanged<String> onVerified; // gives you the token
  final VoidCallback onExpired;

  @override
  State<RecaptchaWidget> createState() => _RecaptchaWidgetState();
}

class _RecaptchaWidgetState extends State<RecaptchaWidget> {
  late final WebViewController _controller;

  String get _html => '''
  <!DOCTYPE html>
  <html>
  <head>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <style>
      body { margin:0; display:flex; justify-content:center; align-items:center; background:transparent; }
    </style>
  </head>
  <body>
    <div class="g-recaptcha"
         data-sitekey="${widget.siteKey}"
         data-callback="onVerify"
         data-expired-callback="onExpire">
    </div>
    <script>
      function onVerify(token) {
        RecaptchaChannel.postMessage(JSON.stringify({event: "verified", token: token}));
      }
      function onExpire() {
        RecaptchaChannel.postMessage(JSON.stringify({event: "expired"}));
      }
    </script>
  </body>
  </html>
  ''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'RecaptchaChannel',
        onMessageReceived: (message) {
          final data = jsonDecode(message.message);
          if (data['event'] == 'verified') {
            widget.onVerified(data['token'] as String);
          } else if (data['event'] == 'expired') {
            widget.onExpired();
          }
        },
      )
      ..loadHtmlString(_html);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 304, // reCAPTCHA checkbox widget's fixed rendered size
      child: WebViewWidget(controller: _controller),
    );
  }
}