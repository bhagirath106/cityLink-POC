part of 'voucher_bloc.dart';

@immutable
abstract class VoucherEvent {}

class GetVoucherHistory extends VoucherEvent {}

class RedeemVoucher extends VoucherEvent {
  final String voucherCode;
  RedeemVoucher({required this.voucherCode});
}

class SetInitialVoucherState extends VoucherEvent {}
