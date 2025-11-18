import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomOtpWidget extends StatelessWidget {
  final bool enableTextField;
  final Function(String) onCompleted;

  const CustomOtpWidget({
    super.key,
    required this.enableTextField,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(right: 10),
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF14335C), // Same color as in the image
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey), // Underline only
        ),
      ),
    );

    return Pinput(
      length: 6,
      enabled: enableTextField,
      autofocus: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
        ),
      ),
      submittedPinTheme: defaultPinTheme,
      showCursor: true,
      onCompleted: onCompleted,
    );
  }
}
