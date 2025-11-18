import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/screens/login_screen/widget/horizontal_divider.dart';
import 'package:cgc_project/screens/login_screen/widget/social_account_login.dart';
import 'package:cgc_project/theme/color_contanst.dart';
import 'package:cgc_project/util/common_validators.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailWidget extends StatefulWidget {
  const EmailWidget({super.key});

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  onObscurePasswordToggle() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          Text(
            Labels.enterEmail,
            style: textTheme.titleMedium!.copyWith(
              color: kBlackIos,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormField(
            controller: emailController,
            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.tertiaryContainer,
              fontWeight: FontWeight.w500,
            ),
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorStyle: textTheme.titleMedium!.copyWith(
                color: colorScheme.error,
              ),
            ),
            validator: CommonValidators.emailValidation,
          ),
          SizedBox(height: size.height / 90),
          Text(
            Labels.emailMessage,
            style: textTheme.titleMedium!.copyWith(
              color: kBlackIos,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: size.height / 28),
          Text(
            Labels.createPassword,
            style: textTheme.titleMedium!.copyWith(
              color: kBlackIos,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscuringCharacter: '*',
            obscureText: obscurePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon:
                    obscurePassword
                        ? Image.asset(Images.visibilityOff)
                        : Icon(Icons.visibility, color: Colors.blueGrey),
                onPressed: onObscurePasswordToggle,
              ),
              errorStyle: textTheme.titleMedium!.copyWith(
                color: colorScheme.error,
              ),
            ),
            validator: CommonValidators.changePasswordValidation,

            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.tertiaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height / 15),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return CustomButton(
                labels: Labels.login,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    getItInstance<SignUpBloc>().add(
                      SetCredentials(
                        index: 2,
                        signUpCredentialData: SignUpCredentialModel(
                          name: state.signUpCredentialData?.name ?? '',
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  }
                },
              );
            },
            // child: ,
          ),
          SizedBox(height: size.height / 28),
          HorizontalDivider(),
          SizedBox(height: size.height / 23),
          SocialAccountLogin(),
        ],
      ),
    );
  }
}
