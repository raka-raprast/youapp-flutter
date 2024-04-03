import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_route_bloc.dart';
import 'package:youapp_flutter/auth/screen/login_screen.dart';
import 'package:youapp_flutter/auth/screen/register_screen.dart';
import 'package:youapp_flutter/components/floating_snackbar.dart';
import 'package:youapp_flutter/components/gradient_scaffold.dart';
import 'package:youapp_flutter/profile/bloc/profile_bloc.dart';
import 'package:youapp_flutter/utils.dart';

class AuthMainScreen extends StatelessWidget {
  const AuthMainScreen({super.key});
  static String route = "/auth";
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthErrorState) {
          FabricSnackbar.floatingSnackBar(
            context: context,
            textColor: Colors.black,
            textStyle: const TextStyle(color: Colors.white),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.redAccent,
            content: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 15),
              child: Text(
                authState.error.message ?? "Something went wrong please try again",
              ),
            ),
          );
        }
        if (authState is AuthLoginState) {
          BlocProvider.of<ProfileBloc>(context).add(const ProfileCreateEvent());
          FabricSnackbar.floatingSnackBar(
            context: context,
            textColor: Colors.black,
            textStyle: const TextStyle(color: Colors.black),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: FabricColors.background1,
            content: const Padding(
              padding: EdgeInsets.only(top: 5, left: 10, bottom: 15),
              child: Text(
                "Successfully logged in",
              ),
            ),
          );
        }
        if (authState is AuthSignUpState) {
          FabricSnackbar.floatingSnackBar(
            context: context,
            textColor: Colors.black,
            textStyle: const TextStyle(color: Colors.black),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: FabricColors.background1,
            content: const Padding(
              padding: EdgeInsets.only(top: 5, left: 10, bottom: 15),
              child: Text(
                "Successfully signed up",
              ),
            ),
          );
          BlocProvider.of<AuthRouteBloc>(context).add(AuthRouteLoginEvent());
        }
      },
      child: BlocBuilder<AuthRouteBloc, AuthRouteState>(builder: (context, state) {
        if (state is AuthRouteLoginState) {
          return const LoginScreen();
        } else if (state is AuthRouteRegisterState) {
          return const RegisterScreen();
        } else if (state is AuthRouteInitialState) {
          return const GradientScaffold();
        }
        return const GradientScaffold();
      }),
    );
  }
}
