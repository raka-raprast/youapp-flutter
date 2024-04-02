import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_flutter/models/error.dart';
import 'package:youapp_flutter/models/user.dart';
import 'package:youapp_flutter/services/auth_services.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? token;
  User? user;
  AuthBloc() : super(AuthInitialState()) {
    on<AuthResetEvent>((event, emit) {
      emit(AuthInitialState());
    });

    on<AuthLoadingEvent>((event, emit) {
      emit(AuthLoadingState());
    });

    on<AuthLoginEvent>(
      (event, emit) async {
        var response = await AuthService.login(event.emailOrUsername, event.password);
        if (response['error'] == null) {
          var data = response["access_token"];
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("authToken", data.toString());
          var userData = JwtDecoder.decode(data);
          user = User.fromJson(userData);
          emit(AuthLoginState(token: data, user: user!));
        } else {
          emit(AuthErrorState(error: ErrorHandler.fromJson(response)));
        }
      },
    );

    on<AuthSignUpEvent>(
      (event, emit) async {
        var response = await AuthService.register(
          event.username,
          event.email,
          event.password,
        );
        if (response['error'] == null) {
          emit(const AuthSignUpState());
        } else {
          emit(AuthErrorState(error: ErrorHandler.fromJson(response)));
        }
      },
    );

    on<AuthInitialEvent>((event, emit) async {
      emit(AuthLoadingState());
      SharedPreferences pref = await SharedPreferences.getInstance();
      var data = pref.getString("authToken");
      token = data;

      if (data != null) {
        var userData = JwtDecoder.decode(data);
        user = User.fromJson(userData);
        emit(AuthLoginState(token: data, user: user!));
      } else {
        emit(AuthInitialState());
      }
    });

    on<AuthLogOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("authToken");
      emit(AuthInitialState());
    });
  }
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoginState extends AuthState {
  final String token;
  final User? user;

  const AuthLoginState({required this.token, required this.user});
  @override
  List<Object?> get props => [token];
}

class AuthSignUpState extends AuthState {
  const AuthSignUpState();
  @override
  List<Object?> get props => [];
}

class AuthForgotPasswordState extends AuthState {
  const AuthForgotPasswordState();
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final ErrorHandler error;

  const AuthErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoadingEvent extends AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthLogOutEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String emailOrUsername;
  final String password;

  const AuthLoginEvent({required this.emailOrUsername, required this.password});
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

class AuthResetEvent extends AuthEvent {}
