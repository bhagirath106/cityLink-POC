part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final ApiStatus status;
  final ErrorModel? error;
  final int currentIndex;
  final String? expiresAt;
  final AuthenticationSuccessModel? signUpResponse;
  final SignUpCredentialModel? signUpCredentialData;
  // final AuthenticationModel? authenticationModel;
  final ButtonStatus buttonStatus;

  const SignUpState({
    this.error,
    required this.status,
    this.currentIndex = 0,
    this.signUpCredentialData,
    this.expiresAt,
    this.signUpResponse,
    // this.authenticationModel,
    required this.buttonStatus,
  });

  static SignUpState initial() => SignUpState(
    status: ApiStatus.initial,
    currentIndex: 0,
    signUpCredentialData: SignUpCredentialModel(
      name: '',
      email: '',
      password: '',
      number: '',
    ),
    signUpResponse: null,
    expiresAt: "2025-04-15T08:49:11Z",
    // authenticationModel: AuthenticationModel(email: ''),
    buttonStatus: ButtonStatus.disabled,
  );

  SignUpState copyWith({
    status,
    authenticationModel,
    error,
    buttonStatus,
    signUpCredentialData,
    signUpResponse,
    currentIndex,
    expiresAt,
  }) {
    return SignUpState(
      currentIndex: currentIndex ?? this.currentIndex,
      signUpCredentialData: signUpCredentialData ?? this.signUpCredentialData,
      expiresAt: expiresAt ?? this.expiresAt,
      // authenticationModel: authenticationModel ?? this.authenticationModel,
      error: error ?? this.error,
      status: status ?? this.status,
      signUpResponse: signUpResponse ?? this.signUpResponse,
      buttonStatus: buttonStatus ?? this.buttonStatus,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    buttonStatus,
    currentIndex,
    expiresAt,
    signUpResponse,
    signUpCredentialData,
  ];
}
