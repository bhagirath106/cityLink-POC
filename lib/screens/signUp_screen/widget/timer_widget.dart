import 'dart:async';
import 'package:cgc_project/theme/color_contanst.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';

class CountdownTimerText extends StatefulWidget {
  final TextTheme textTheme;
  final int start; // in seconds

  const CountdownTimerText({
    super.key,
    this.start = 10,
    required this.textTheme,
  });

  @override
  State<CountdownTimerText> createState() => _CountdownTimerTextState();
}

class _CountdownTimerTextState extends State<CountdownTimerText> {
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.start;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime <= 1) {
        timer.cancel();
      }
      setState(() {
        _remainingTime = (_remainingTime - 1).clamp(0, widget.start);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final formatted = Duration(
      seconds: seconds,
    ).toString().split('.').first.padLeft(8, "0");
    return formatted.substring(3); // mm:ss format
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${Labels.verifyTimerLabel} (${_formatTime(_remainingTime)})',
      style: widget.textTheme.labelMedium!.copyWith(
        color: kBlackIos,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
