part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  final ApiStatus status;
  final ErrorModel? error;
  final ButtonStatus buttonStatus;
  final WalletModel? walletModel;
  final String? selectedPaymentMethod;

  const WalletState({
    this.error,
    required this.status,
    required this.buttonStatus,
    this.walletModel,
    this.selectedPaymentMethod,
  });

  static WalletState initial() => WalletState(
    status: ApiStatus.initial,
    error: null,
    buttonStatus: ButtonStatus.disabled,
    walletModel: null,
    selectedPaymentMethod: null,
  );

  WalletState copyWith({
    status,
    ErrorModel? error,
    buttonStatus,
    WalletModel? walletModel,
    String? selectedPaymentMethod,
  }) {
    return WalletState(
      error: error ?? this.error,
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      walletModel: walletModel ?? this.walletModel,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    buttonStatus,
    walletModel,
    selectedPaymentMethod,
  ];
}
