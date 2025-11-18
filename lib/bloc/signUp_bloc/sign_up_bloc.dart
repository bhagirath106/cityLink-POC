import 'package:cgc_project/models/error_model.dart';
import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/models/authentication_model/authentication_success_model.dart';
import 'package:cgc_project/repositories/authentication/authentication.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authenticationRepository;
  SignUpBloc({required this.authenticationRepository})
    : super(SignUpState.initial()) {
    on<SetCredentials>((event, emit) async {
      emit(
        state.copyWith(
          currentIndex: event.index,
          signUpCredentialData: event.signUpCredentialData,
        ),
      );
    });
    on<GetOtpEvent>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        Response response = await authenticationRepository.getOtpAuthentication(
          event.number,
        );
        if (response.statusCode == 200) {
          emit(
            state.copyWith(
              status: ApiStatus.success,
              expiresAt: response.data['expires_at'],
            ),
          );
        } else {
          emit(state.copyWith(status: ApiStatus.failure, error: response));
        }
      } on DioException catch (error) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            error: ErrorModel.fromJson(error.response?.data),
          ),
        );
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      Response response;
      try {
        response = await authenticationRepository.verifyOtpAuthentication(
          event.number,
          event.otp,
        );
        if (response.statusCode == 200) {
          SignUpCredentialModel? signUpCredentialData =
              state.signUpCredentialData;
          Response? signUpResponse = await authenticationRepository
              .registerAuthentication(signUpCredentialData!);
          if (signUpResponse.statusCode == 200) {
            LocalStorageServices.setAuth(true);
            LocalStorageServices.setAuthToken(
              signUpResponse.data['authentication_token'],
            );
            LocalStorageServices.setEmailId(signUpResponse.data['email']);
            LocalStorageServices.saveUserId(signUpResponse.data['id']);
            emit(
              state.copyWith(
                status: ApiStatus.verifyOtpSuccess,
                signUpResponse: AuthenticationSuccessModel.fromJson(
                  signUpResponse.data,
                ),
              ),
            );
          }
        } else {
          emit(state.copyWith(status: ApiStatus.failure, error: response));
        }
      } on DioException catch (error) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            error: ErrorModel.fromJson(error.response?.data),
          ),
        );
      }
    });
    on<SetStatusInitial>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.initial));
    });
  }
}
