import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/bloc/signIn_bloc/sign_in_bloc.dart';
import 'package:cgc_project/bloc/signUp_bloc/sign_up_bloc.dart';
import 'package:cgc_project/bloc/voucher/voucher_bloc.dart';
import 'package:cgc_project/bloc/wallet/wallet_bloc.dart';
import 'package:cgc_project/routing/routing.dart';
import 'package:cgc_project/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/di.dart';

class CgcApp extends StatelessWidget {
  final String flavor;
  final String initialRoute;
  const CgcApp({super.key, required this.flavor, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late ThemeData themeData = AppTheme.buildTheme(size);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getItInstance<SignUpBloc>()),
        BlocProvider(create: (context) => getItInstance<SignInBloc>()),
        BlocProvider(create: (context) => getItInstance<SearchLocationBloc>()),
        BlocProvider(create: (context) => getItInstance<RouteBloc>()),
        BlocProvider(create: (context) => getItInstance<WalletBloc>()),
        BlocProvider(create: (context) => getItInstance<VoucherBloc>()),
      ],
      child: MaterialApp(
        theme: themeData,
        initialRoute: initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
