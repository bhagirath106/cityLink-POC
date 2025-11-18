part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class GetPaymentData extends WalletEvent {}

class WalletMethodSelected extends WalletEvent {
  final String selectedMethod;

  WalletMethodSelected(this.selectedMethod);
}

class SetInitialWalletState extends WalletEvent {}
