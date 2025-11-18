import 'package:cgc_project/models/Error_model.dart';
import 'package:cgc_project/models/authentication_model/authentication_success_model.dart';
import 'package:cgc_project/models/authentication_model/customer_model.dart';
import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/repositories/authentication/authentication.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository authenticationRepository;
  SignInBloc({required this.authenticationRepository})
    : super(SignInState.initial()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        Response response = await authenticationRepository.loginAuthentication(
          event.signUpCredentialData,
        );
        if (response.statusCode == 200) {
          LocalStorageServices.setAuth(true);
          LocalStorageServices.setAuthToken(
            response.data['authentication_token'],
          );
          LocalStorageServices.setEmailId(response.data['email']);
          LocalStorageServices.saveUserId(response.data['id']);
          emit(
            state.copyWith(
              status: ApiStatus.success,
              signUpResponse: AuthenticationSuccessModel.fromJson(
                response.data,
              ),
            ),
          );
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
    on<CustomerDetail>((event, emit) async {
      Response? response;
      try {
        if (state.customerData?.id == null) {
          response = await authenticationRepository.getCustomerDetail();
        }
        if (response?.statusCode == 200) {
          emit(
            state.copyWith(
              status: ApiStatus.success,
              customerData: CustomerModel.fromJson(response?.data),
            ),
          );
        }
      } on DioException catch (error) {
        if (DioExceptionType.connectionTimeout == error.type) {
          emit(state.copyWith(status: ApiStatus.failure));
        }
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
  }
}
