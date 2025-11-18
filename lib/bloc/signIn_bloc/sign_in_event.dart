part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class LoginEvent extends SignInEvent {
  final SignUpCredentialModel signUpCredentialData;
  LoginEvent({required this.signUpCredentialData});
}

class CustomerDetail extends SignInEvent {}
