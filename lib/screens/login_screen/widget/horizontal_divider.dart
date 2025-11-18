import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFB8B8B8), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            Labels.horizontalLoginLabel,
            style: TextStyle(color: Color(0xFFB8B8B8), fontSize: 14),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFB8B8B8), thickness: 1)),
      ],
    );
  }
}
