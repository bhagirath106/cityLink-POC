part of 'voucher_bloc.dart';

class VoucherState extends Equatable {
  final ApiStatus status;
  final ErrorModel? error;
  final ButtonStatus? buttonStatus;
  final VoucherModel? getVoucherData;
  final RedeemVoucherModel? redeemVoucherData;

  const VoucherState({
    required this.status,
    this.error,
    this.buttonStatus,
    this.getVoucherData,
    this.redeemVoucherData,
  });

  static VoucherState initial() => VoucherState(
    status: ApiStatus.initial,
    error: null,
    buttonStatus: ButtonStatus.disabled,
    getVoucherData: null,
    redeemVoucherData: null,
  );

  VoucherState copyWith({
    status,
    ErrorModel? error,
    buttonStatus,
    VoucherModel? getVoucherData,
    RedeemVoucherModel? redeemVoucherData,
  }) {
    return VoucherState(
      error: error ?? this.error,
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      getVoucherData: getVoucherData ?? this.getVoucherData,
      redeemVoucherData: redeemVoucherData ?? this.redeemVoucherData,
    );
  }

  @override
  List<Object?> get props => [
    error,
    status,
    buttonStatus,
    getVoucherData,
    redeemVoucherData,
  ];
}
