import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/voucher/voucher_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/screens/voucher_screen/widget/voucher_card_widget.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/util/uppercase_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  TextEditingController voucherController = TextEditingController();
  RouteState routeState = getItInstance<RouteBloc>().state;
  VoucherState voucherState = getItInstance<VoucherBloc>().state;

  @override
  void dispose() {
    getItInstance<VoucherBloc>().add(SetInitialVoucherState());
    voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimaryContainer,
      appBar: AppBar(
        toolbarHeight: size.height / 9,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              Labels.voucher,
              style: textTheme.labelMedium!.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${Labels.toPay} ${routeState.getRouteData.routes.first.price?.currency} ${routeState.getRouteData.routes.first.price?.amount}',
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
          vertical: size.height / 40,
          horizontal: size.width / 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<VoucherBloc, VoucherState>(
                listener: (context, state) {
                  if (state.status == ApiStatus.navigate) {
                    if (state.redeemVoucherData?.redeemVoucher?.status ??
                        false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.redeemVoucherData?.redeemVoucher?.message ??
                                '',
                          ),
                        ),
                      );
                      if (state.redeemVoucherData?.redeemVoucher?.status !=
                          null) {
                        if (state.redeemVoucherData!.redeemVoucher!.status!) {
                          final navigator = Navigator.of(context);
                          Future.delayed(Duration(seconds: 2), () {
                            if (mounted) {
                              navigator.pop();
                            }
                          });
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.redeemVoucherData?.redeemVoucher?.message ??
                                '',
                          ),
                        ),
                      );
                    }
                  } else if (state.status == ApiStatus.failure) {
                    CommonMethods.showSimpleDialog(
                      context,
                      state.error?.error?.userFriendly?.title ?? '',
                      state.error?.error?.userFriendly?.description ?? '',
                    );
                  }
                },
                child: TextFormField(
                  controller: voucherController,
                  onChanged: (value) {
                    setState(() {
                      showActiveByColor(colorScheme);
                    });
                  },
                  style: textTheme.labelMedium!.copyWith(
                    color: colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [UpperCaseTextFormatter()],
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: colorScheme.secondary,
                    filled: true,
                    suffixIcon: TextButton(
                      onPressed: () {
                        if (voucherController.text.isNotEmpty &&
                            voucherController.text.length > 3) {
                          getItInstance<VoucherBloc>().add(
                            RedeemVoucher(
                              voucherCode: voucherController.text.toUpperCase(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        Labels.apply,
                        style: textTheme.labelMedium!.copyWith(
                          color: showActiveByColor(colorScheme),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    hintText: Labels.enterCode,
                    hintStyle: textTheme.labelMedium!.copyWith(
                      color: colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height / 43),
              Text(
                Labels.appliedVoucher,
                style: textTheme.labelMedium!.copyWith(
                  color: colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height / 89),
              if (voucherState
                  .getVoucherData!
                  .voucherRedemptionHistory
                  .isNotEmpty)
                ...List.generate(
                  voucherState.getVoucherData!.voucherRedemptionHistory.length,
                  (index) {
                    return VoucherCard(
                      label:
                          voucherState
                              .getVoucherData!
                              .voucherRedemptionHistory[index]
                              .customCode ??
                          '',
                      labelColor: colorScheme.surface,
                      title:
                          voucherState
                              .getVoucherData!
                              .voucherRedemptionHistory[index]
                              .compaignName ??
                          '',
                      description:
                          voucherState
                                      .getVoucherData!
                                      .voucherRedemptionHistory[index]
                                      .expiryDate !=
                                  null
                              ? '${Labels.voucherExpiry}:${voucherState.getVoucherData!.voucherRedemptionHistory[index].expiryDate}'
                              : 'N/A',
                      subtitle:
                          voucherState
                              .getVoucherData!
                              .voucherRedemptionHistory[index]
                              .compaignDescription ??
                          '',
                      actionText: '',
                      onActionTap: () {
                        // remove logic
                      },
                      image: Images.sparkles,
                      isExpired: true,
                    );
                  },
                ),
              if (voucherState.getVoucherData!.voucherRedemptionHistory.isEmpty)
                Center(
                  child: Text(
                    Labels.noVoucher,
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color showActiveByColor(ColorScheme colorScheme) {
    return voucherController.text.isNotEmpty &&
            voucherController.text.length > 3
        ? colorScheme.onTertiaryContainer
        : colorScheme.primary.withAlpha(80);
  }
}
