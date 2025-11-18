import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/wallet/wallet_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/get_route_data.dart';
import 'package:cgc_project/screens/payment_screen/widget/payment_method_card_widget.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    GetRouteDataModel getRouteData =
        getItInstance<RouteBloc>().state.getRouteData;
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        getItInstance<WalletBloc>().add(SetInitialWalletState());
      },
      child: Scaffold(
        backgroundColor: colorScheme.onPrimaryContainer,
        appBar: AppBar(
          toolbarHeight: size.height / 9,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                Labels.paymentMode,
                style: textTheme.labelMedium!.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${Labels.toPay} ${getRouteData.routes.first.price?.currency} ${getRouteData.routes.first.price?.amount}',
                style: textTheme.titleMedium!.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height / 50,
            horizontal: size.width / 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  return Column(
                    children: List.generate(
                      state.walletModel?.paymentMethods.length ??
                          0, // Replace 1 with the actual number of items you want to generate
                      (index) => PaymentMethodCardWidget(
                        icon: Icons.account_balance_wallet_rounded,
                        title:
                            state.walletModel!.paymentMethods[index].type ?? '',
                        subtitle:
                            state
                                        .walletModel!
                                        .paymentMethods[index]
                                        .properties !=
                                    null
                                ? '${Labels.balance}: ${getRouteData.routes.first.price?.currency} ${state.walletModel!.paymentMethods[index].properties!.minimumBalance}'
                                : null,
                        groupValue: state.selectedPaymentMethod ?? 'wallet',
                        onChanged: (value) {
                          getItInstance<WalletBloc>().add(
                            WalletMethodSelected(value!),
                          );
                          final navigate = Navigator.pop(context);
                          Future.delayed(Duration(seconds: 2), () {
                            navigate;
                            getItInstance<WalletBloc>().add(
                              SetInitialWalletState(),
                            );
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height / 35),
              Padding(
                padding: EdgeInsets.only(left: size.width / 50),
                child: Text(
                  Labels.addPayment,
                  style: textTheme.labelMedium!.copyWith(
                    color: colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: size.height / 40),
              Card(
                child: Column(
                  children: [
                    buildIconTextRowWidget(
                      size,
                      textTheme,
                      colorScheme,
                      'Add Credit/Debit Card',
                    ),
                    Divider(
                      thickness: 1,
                      color: colorScheme.onTertiaryContainer,
                    ),
                    buildIconTextRowWidget(
                      size,
                      textTheme,
                      colorScheme,
                      'Method 2',
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height / 5),
              CustomButton(labels: Labels.addMoneyToAccount, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildIconTextRowWidget(
    Size size,
    TextTheme textTheme,
    ColorScheme colorScheme,
    String title,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height / 60,
        horizontal: size.width / 30,
      ),
      child: Row(
        children: [
          Image.asset(Images.credit, color: colorScheme.onTertiaryContainer),
          SizedBox(width: size.width / 40),
          Text(
            title,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  // Card paymentMethodCard(
  //   Size size,
  //   ColorScheme colorScheme,
  //   TextTheme textTheme,
  //   IconData icon,
  //   String title, {
  //   String? subtitle,
  // }) {
  //   return ;
  // }
}
