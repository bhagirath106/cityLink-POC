import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          width: size.width / 9,
          margin: EdgeInsets.only(
            right: index != 3 ? 10 : 20,
          ), // avoid extra padding after last
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return LinearProgressIndicator(
                value: index <= state.currentIndex ? 1 : 0,
                // example: only 1st step active
                backgroundColor: Colors.white30,
                color: Colors.white,
                minHeight: 2,
              );
            },
          ),
        ),
      ),
    );
  }
}
