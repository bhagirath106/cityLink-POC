import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/bloc/signIn_bloc/sign_in_bloc.dart';
import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/bloc/voucher/voucher_bloc.dart';
import 'package:cgc_project/bloc/wallet/wallet_bloc.dart';
import 'package:cgc_project/repositories/authentication/authentication.dart';
import 'package:cgc_project/repositories/auto_completion_location/auto_completion.dart';
import 'package:cgc_project/repositories/routes/routes_info.dart';
import 'package:cgc_project/repositories/voucher/voucher_repo.dart';
import 'package:cgc_project/repositories/wallet/wallet_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt getItInstance = GetIt.instance;

void init(String env) {
  //Register of local storage
  getItInstance.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Register the Repository
  getItInstance.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(),
  );
  getItInstance.registerLazySingleton<AutoCompletionLocationRepository>(
    () => AutoCompletionLocationRepository(),
  );
  getItInstance.registerLazySingleton<RoutesInfoRepository>(
    () => RoutesInfoRepository(),
  );
  getItInstance.registerLazySingleton<WalletRepository>(
    () => WalletRepository(),
  );
  getItInstance.registerLazySingleton<VoucherRepository>(
    () => VoucherRepository(),
  );

  // Register the Bloc
  getItInstance.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(authenticationRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<SignInBloc>(
    () => SignInBloc(authenticationRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<SearchLocationBloc>(
    () => SearchLocationBloc(autoCompletionLocationRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<RouteBloc>(
    () => RouteBloc(getRoutesInfoRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<WalletBloc>(
    () => WalletBloc(walletRepository: getItInstance()),
  );
  getItInstance.registerLazySingleton<VoucherBloc>(
    () => VoucherBloc(voucherRepository: getItInstance()),
  );
}
