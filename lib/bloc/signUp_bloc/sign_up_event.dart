part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class InitState extends SignUpEvent {}

class GoogleSignUpRequest extends SignUpEvent {
  final String? fullName;
  final String? email;
  final String? selectedRole;
  final bool? isTC;

  GoogleSignUpRequest({
    this.selectedRole,
    this.fullName,
    this.email,
    this.isTC,
  });
}

class SignUpRequest extends SignUpEvent {
  final SignUpCredentialModel? signUpCredentialData;

  SignUpRequest({this.signUpCredentialData});
}

class SetCredentials extends SignUpEvent {
  final int? index;
  final SignUpCredentialModel? signUpCredentialData;
  SetCredentials({this.index, this.signUpCredentialData});
}

class GetOtpEvent extends SignUpEvent {
  final String number;
  GetOtpEvent({required this.number});
}

class VerifyOtpEvent extends SignUpEvent {
  final String number;
  final String otp;
  VerifyOtpEvent({required this.otp, required this.number});
}

class SetStatusInitial extends SignUpEvent {
  SetStatusInitial();
}

class FormIsValid extends SignUpEvent {}

class FormInvalid extends SignUpEvent {}
