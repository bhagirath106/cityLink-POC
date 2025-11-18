import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/theme/color_contanst.dart';
import 'package:cgc_project/util/common_validators.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberWidget extends StatefulWidget {
  const NumberWidget({super.key});

  @override
  State<NumberWidget> createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  String countryCode = '+91';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  void _onCountryChange(CountryCode countryCodes) {
    setState(() {
      countryCode = countryCodes.dialCode!;
    });
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
            Labels.enterNumber,
            style: textTheme.titleMedium!.copyWith(
              color: kBlackIos,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormField(
            controller: numberController,
            autofocus: true,
            validator:
                (value) =>
                    CommonValidators.validatePhoneNumber(value, countryCode),
            maxLength: 10,
            decoration: InputDecoration(
              errorStyle: textTheme.titleMedium!.copyWith(
                color: colorScheme.error,
              ),
              prefix: Container(
                width: size.width / 4.7,
                padding: EdgeInsets.only(left: 8, bottom: 0),
                child: Row(
                  children: [
                    CountryCodePicker(
                      padding: EdgeInsets.zero,
                      onChanged: _onCountryChange,
                      initialSelection: 'IN',
                      showFlagMain: false,
                      showCountryOnly: true,
                      showFlagDialog: true,
                      enabled: true,
                      textStyle: textTheme.bodyLarge!.copyWith(
                        color: colorScheme.tertiaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      dialogTextStyle: textTheme.bodyLarge!.copyWith(
                        color: colorScheme.tertiaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      boxDecoration: BoxDecoration(
                        color: Colors.white, // Optional background color
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Optional rounded corners
                      ),
                      searchStyle: textTheme.bodyLarge!.copyWith(
                        color: colorScheme.tertiaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      searchDecoration: InputDecoration(
                        hintText: Labels.searchCode,
                      ),
                      topBarPadding: EdgeInsets.zero,
                    ),
                    Container(
                      height: 30, // height of the vertical divider
                      width: 1.5,
                      color: Color.fromRGBO(221, 221, 221, 1),
                    ),
                  ],
                ),
              ),
            ),
            keyboardType: TextInputType.phone,
            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.tertiaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height / 15),
          BlocConsumer<SignUpBloc, SignUpState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              switch (state.status) {
                case ApiStatus.success:
                  getItInstance<SignUpBloc>().add(
                    SetCredentials(
                      index: 3,
                      signUpCredentialData: SignUpCredentialModel(
                        name: state.signUpCredentialData?.name ?? '',
                        number: '$countryCode${numberController.text}',
                        email: state.signUpCredentialData?.email ?? '',
                        password: state.signUpCredentialData?.password ?? '',
                      ),
                    ),
                  );
                  context.read<SignUpBloc>().add(SetStatusInitial());
                  break;
                case ApiStatus.failure:
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
                  break;

                default:
                  break; // No action on loading or initial state
              }
            },
            builder: (context, state) {
              if (state.status == ApiStatus.loading) {
                return CustomButton(
                  labels: Labels.getOtp,
                  color: colorScheme.onSecondaryContainer.withAlpha(60),
                  onPressed: () {},
                );
              } else {
                return CustomButton(
                  labels: Labels.getOtp,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _dismissKeyboard(context);
                      getItInstance<SignUpBloc>().add(
                        GetOtpEvent(
                          number: '$countryCode${numberController.text}',
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
