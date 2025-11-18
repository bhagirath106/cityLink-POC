import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/signUp_screen/widget/custom_button_text.dart';
import 'package:cgc_project/screens/signUp_screen/widget/otp_input_widget.dart';
import 'package:cgc_project/screens/signUp_screen/widget/timer_widget.dart';
import 'package:cgc_project/theme/color_contanst.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtpWidget extends StatefulWidget {
  const VerifyOtpWidget({super.key});

  @override
  State<VerifyOtpWidget> createState() => _VerifyOtpWidgetState();
}

class _VerifyOtpWidgetState extends State<VerifyOtpWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool enableTextField = true;
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return Text(
                '${Labels.verifyLabel} ${state.signUpCredentialData?.number ?? ''}',
                style: textTheme.labelMedium!.copyWith(
                  color: kBlackIos,
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
          CustomOtpWidget(
            enableTextField: enableTextField,
            onCompleted: (value) {
              otpValue = value;
            },
          ),
          SizedBox(height: size.height / 90),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return CountdownTimerText(
                start: getEstimatedSecondsTo(
                  state.expiresAt ?? "2025-04-15T08:49:11Z",
                ),
                textTheme: textTheme,
              );
            },
          ),
          SizedBox(height: size.height / 15),
          BlocConsumer<SignUpBloc, SignUpState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == ApiStatus.verifyOtpSuccess) {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.mapRouteSelectionScreen,
                );
                context.read<SignUpBloc>().add(SetStatusInitial());
              } else if (state.status == ApiStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: colorScheme.error,
                    duration: const Duration(seconds: 3),
                    content: Text(
                      state.error?.error?.details ?? 'Something went wrong',
                    ),
                  ),
                );
                context.read<SignUpBloc>().add(SetStatusInitial());
              }
            },
            builder: (context, state) {
              if (state.status == ApiStatus.loading ||
                  state.status == ApiStatus.verifyOtpSuccess ||
                  otpValue.isEmpty) {
                return CustomButton(
                  labels: Labels.verify,
                  color: colorScheme.onSecondaryContainer.withAlpha(60),
                  onPressed: () {},
                );
              } else {
                return CustomButton(
                  labels: Labels.verify,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignUpBloc>().add(
                        VerifyOtpEvent(
                          otp: otpValue,
                          number: state.signUpCredentialData!.number!,
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
          SizedBox(height: size.height / 37),
          CustomButtonText(
            textTheme: textTheme,
            colorScheme: colorScheme,
            size: size,
          ),
        ],
      ),
    );
  }

  int getEstimatedSecondsTo(String utcTimeString) {
    final targetTime = DateTime.parse(utcTimeString).toUtc();
    final currentTime = DateTime.now().toUtc();
    final difference = targetTime.difference(currentTime);
    return difference.inSeconds;
  }
}
