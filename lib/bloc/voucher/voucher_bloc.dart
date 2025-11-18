import 'package:cgc_project/bloc/signIn_bloc/sign_in_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/Error_model.dart';
import 'package:cgc_project/models/authentication_model/customer_model.dart';
import 'package:cgc_project/models/voucher/redeem_voucher_mdoel.dart';
import 'package:cgc_project/models/voucher/voucher_model.dart';
import 'package:cgc_project/repositories/voucher/voucher_repo.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final VoucherRepository voucherRepository;
  VoucherBloc({required this.voucherRepository})
    : super(VoucherState.initial()) {
    on<GetVoucherHistory>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        Response response = await voucherRepository.getVoucherHistory();
        if (response.statusCode == 200) {
          final VoucherModel voucherData = VoucherModel.fromJson(response.data);
          emit(
            state.copyWith(
              status: ApiStatus.success,
              getVoucherData: voucherData,
            ),
          );
        }
      } on DioException catch (e) {
        if (e.response?.data != null) {
          emit(
            state.copyWith(
              status: ApiStatus.failure,
              error: e.response?.data['message'],
            ),
          );
        }
      }
    });

    on<RedeemVoucher>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        CustomerModel? customerData =
            getItInstance<SignInBloc>().state.customerData;
        Response response = await voucherRepository.redeemVoucher(
          event.voucherCode,
          customerData?.customer?.resourceId ?? '',
          customerData?.userWallet?.resourceId ?? '',
          customerData?.customer?.createdBy ?? '',
        );
        if (response.statusCode == 200) {
          emit(
            state.copyWith(
              status: ApiStatus.navigate,
              redeemVoucherData: RedeemVoucherModel.fromJson(response.data),
            ),
          );
        }
      } on DioException catch (error) {
        if (error.response?.data != null) {
          emit(
            state.copyWith(
              status: ApiStatus.failure,
              error: ErrorModel.fromJson(error.response?.data),
            ),
          );
        }
      }
    });

    on<SetInitialVoucherState>((event, emit) {
      emit(state.copyWith(status: ApiStatus.initial));
    });
  }
}
