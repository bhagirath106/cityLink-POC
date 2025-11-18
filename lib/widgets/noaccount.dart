import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: size.height / 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Labels.noAccountLabel, style: textTheme.labelMedium),
          SizedBox(width: size.width / 50),
          GestureDetector(
            onTap: () {
              getItInstance<SignUpBloc>().add(
                SetCredentials(index: 0),
              ); //Resetting the Index of step_indicator to zero.
              Navigator.pushNamed(context, RoutesName.signUp);
            },
            child: Text(
              Labels.signUp,
              style: textTheme.labelMedium!.copyWith(color: Color(0xff4f99fe)),
            ),
          ),
        ],
      ),
    );
  }
}
