import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';

class GoToLogin extends StatelessWidget {
  const GoToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(Labels.haveAnAccount, style: textTheme.labelMedium),
        SizedBox(width: size.width / 70),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, RoutesName.login);
          },
          child: Text(
            Labels.login,
            style: textTheme.labelMedium!.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
