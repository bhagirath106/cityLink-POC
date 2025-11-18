import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/theme/color_contanst.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtonText extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final Size size;

  const CustomButtonText({
    super.key,
    required this.textTheme,
    required this.colorScheme,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Labels.didNotReceive,
          style: textTheme.labelMedium!.copyWith(
            color: kBlackIos,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: size.width / 80),
        GestureDetector(
          onTap: () {
            sendOtpAgain(context);
          },
          child: Text(
            Labels.resendCode,
            style: textTheme.labelMedium!.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void sendOtpAgain(BuildContext context) {
    String? number =
        context.read<SignUpBloc>().state.signUpCredentialData?.number;
    getItInstance<SignUpBloc>().add(GetOtpEvent(number: number!));
  }
}
