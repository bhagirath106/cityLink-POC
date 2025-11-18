part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final ApiStatus status;
  final ErrorModel? error;
  final int currentIndex;
  final String? expiresAt;
  final AuthenticationSuccessModel? signUpResponse;
  final SignUpCredentialModel? signUpCredentialData;
  final ButtonStatus buttonStatus;
  final CustomerModel? customerData;

  const SignInState({
    this.error,
    required this.status,
    this.currentIndex = 0,
    this.signUpCredentialData,
    this.expiresAt,
    this.signUpResponse,
    this.customerData,
    required this.buttonStatus,
  });

  static SignInState initial() => SignInState(
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
    customerData: null,
    buttonStatus: ButtonStatus.disabled,
  );

  SignInState copyWith({
    status,
    authenticationModel,
    error,
    buttonStatus,
    signUpCredentialData,
    signUpResponse,
    currentIndex,
    expiresAt,
    CustomerModel? customerData,
  }) {
    return SignInState(
      currentIndex: currentIndex ?? this.currentIndex,
      signUpCredentialData: signUpCredentialData ?? this.signUpCredentialData,
      expiresAt: expiresAt ?? this.expiresAt,
      customerData: customerData ?? this.customerData,
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
    customerData,
  ];
}
