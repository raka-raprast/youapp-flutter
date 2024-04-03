// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_route_bloc.dart';
import 'package:youapp_flutter/auth/screen/auth_main_screen.dart';
import 'package:youapp_flutter/components/main_scaffold.dart';
import 'package:youapp_flutter/profile/bloc/profile_bloc.dart';
import 'package:youapp_flutter/profile/bloc/update_profile_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await SharedPreferences.getInstance()
  //   ..clear();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()
            ..add(
              AuthInitialEvent(),
            ),
        ),
        BlocProvider<AuthRouteBloc>(
          create: (_) => AuthRouteBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(),
        ),
        BlocProvider<UpdateProfileBloc>(
          create: (_) => UpdateProfileBloc(),
        ),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, stateAuth) {
        if (stateAuth is AuthInitialState) {
          BlocProvider.of<AuthRouteBloc>(context).add(AuthRouteLoginEvent());
        }
      }, builder: (context, stateAuth) {
        return MaterialApp.router(
          routerConfig: GoRouter(
              routes: [
                GoRoute(
                  name: 'auth',
                  path: AuthMainScreen.route,
                  builder: (context, state) => Material(child: AuthMainScreen()),
                ),
                GoRoute(
                  name: 'profile',
                  path: MainScaffold.route,
                  builder: (context, state) => Material(child: MainScaffold()),
                ),
              ],
              redirect: (BuildContext context, GoRouterState state) {
                if (stateAuth is! AuthLoginState) {
                  return AuthMainScreen.route;
                }
                return null;
              }),
          title: 'Youapp',
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true, fontFamily: 'Inter'),
        );
      }),
    );
  }
}
