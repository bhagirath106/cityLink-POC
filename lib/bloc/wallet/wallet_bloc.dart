import 'package:cgc_project/models/Error_model.dart';
import 'package:cgc_project/models/wallet/wallet_model.dart';
import 'package:cgc_project/repositories/wallet/wallet_repo.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  WalletBloc({required this.walletRepository}) : super(WalletState.initial()) {
    on<GetPaymentData>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        Response response = await walletRepository.getPaymentInfo();
        if (response.statusCode == 200) {
          emit(
            state.copyWith(
              status: ApiStatus.success,
              walletModel: WalletModel.fromJson(response.data),
            ),
          );
        }
      } on DioException {
        emit(state.copyWith(status: ApiStatus.failure));
      }
    });
    on<WalletMethodSelected>((event, emit) {
      emit(state.copyWith(selectedPaymentMethod: event.selectedMethod));
    });
    on<SetInitialWalletState>((event, emit) {
      emit(state.copyWith(status: ApiStatus.initial));
    });
  }
}
