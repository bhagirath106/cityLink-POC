import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/theme/color_contanst.dart';
import 'package:cgc_project/util/common_validators.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NameWidget extends StatefulWidget {
  const NameWidget({super.key});

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
            Labels.fullName,
            style: textTheme.titleMedium!.copyWith(
              color: kBlackIos,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormField(
            controller: nameController,
            autofocus: true,
            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.tertiaryContainer,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              errorStyle: textTheme.titleMedium!.copyWith(
                color: colorScheme.error,
              ),
            ),
            validator: CommonValidators.onFieldRequired,
          ),
          SizedBox(height: size.height / 90),
          Text(
            Labels.nameMessage,
            style: textTheme.titleMedium!.copyWith(
              color: kBlackIos,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: size.height / 15),
          CustomButton(
            labels: Labels.setEmail,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                getItInstance<SignUpBloc>().add(
                  SetCredentials(
                    index: 1,
                    signUpCredentialData: SignUpCredentialModel(
                      name: nameController.text,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
