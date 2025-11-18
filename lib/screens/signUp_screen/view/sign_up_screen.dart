import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/screens/signUp_screen/view/email_screen.dart';
import 'package:cgc_project/screens/signUp_screen/widget/go_to_login.dart';
import 'package:cgc_project/screens/signUp_screen/view/name_screen.dart';
import 'package:cgc_project/screens/signUp_screen/view/number_screen.dart';
import 'package:cgc_project/screens/signUp_screen/widget/step_indicator.dart';
import 'package:cgc_project/screens/signUp_screen/view/verify_otp_screen.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                if (state.currentIndex == 0) {
                  Navigator.of(context).pop(); // or Navigator.pop(context);
                } else {
                  getItInstance<SignUpBloc>().add(
                    SetCredentials(index: state.currentIndex - 1),
                  );
                }
              },
            );
          },
        ),
        toolbarHeight: height / 8,
        title: StepIndicator(),
        actions: [
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return Text(
                'Step ${state.currentIndex + 1}/4',
                style: textTheme.labelMedium!.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: size.width / 28.0),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: size.width / 20,
              bottom: height / 55,
            ),
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Text(
                  getLabel(
                    state.currentIndex,
                    state.signUpCredentialData?.name,
                  ),
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height / 37,
            horizontal: size.width / 24,
          ),
          child: SizedBox(
            height: height / 1.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state.currentIndex == 1) {
                      return EmailWidget();
                    } else if (state.currentIndex == 2) {
                      return NumberWidget();
                    } else if (state.currentIndex == 3) {
                      return VerifyOtpWidget();
                    }
                    return NameWidget();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [GoToLogin()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getLabel(int index, String? label) {
    if (index == 0) return Labels.whatCall;
    if (index == 1) return '${Labels.welcome} ${label ?? ''}';
    if (index == 2) return Labels.whatNumber;
    return Labels.almostDone;
  }
}
