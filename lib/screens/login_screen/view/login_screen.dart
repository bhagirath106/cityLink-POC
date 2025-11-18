import 'package:cgc_project/bloc/signIn_bloc/sign_in_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/login_screen/widget/horizontal_divider.dart';
import 'package:cgc_project/screens/login_screen/widget/social_account_login.dart';
import 'package:cgc_project/util/common_validators.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:cgc_project/widgets/noaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    debugPrint('height: ${size.height}');
    debugPrint('width: ${size.width}');
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(bottom: size.height / 25),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Color(0xff15335c),
        toolbarHeight: size.height / 10,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(bottom: size.height / 25),
          child: Text(
            Labels.welcomeBack,
            style: textTheme.titleLarge!.copyWith(
              color: colorScheme.secondary,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height / 36,
              horizontal: size.width / 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Labels.enterEmail,
                  style: textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  style: textTheme.bodyLarge!.copyWith(
                    color: colorScheme.tertiaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    errorStyle: textTheme.titleMedium!.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                  validator: CommonValidators.emailValidation,
                  autofocus: true,
                ),
                SizedBox(height: size.height / 20),
                Text(
                  Labels.enterPassword,
                  style: textTheme.labelMedium!.copyWith(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          Labels.forgotPassword,
                          style: TextStyle(color: Color(0xFF4989FF)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height / 14.8),
                BlocConsumer<SignInBloc, SignInState>(
                  listenWhen: (prev, curr) => prev.status != curr.status,
                  listener: (context, state) {
                    if (state.status == ApiStatus.success) {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesName.mapRouteSelectionScreen,
                      );
                    } else if (state.status == ApiStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: colorScheme.error,
                          duration: const Duration(seconds: 3),
                          content: Text(state.error?.error?.details ?? ''),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.status == ApiStatus.loading ||
                        state.status == ApiStatus.success) {
                      return CustomButton(
                        labels: Labels.login,
                        color: colorScheme.onSecondaryContainer.withAlpha(60),
                        onPressed: () {},
                      );
                    } else {
                      return CustomButton(
                        labels: Labels.login,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            _dismissKeyboard(context);
                            getItInstance<SignInBloc>().add(
                              LoginEvent(
                                signUpCredentialData: SignUpCredentialModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: size.height / 30),
                HorizontalDivider(),
                SizedBox(height: size.height / 30),
                SocialAccountLogin(),
                SizedBox(height: size.height / 5.9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [NoAccount()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
