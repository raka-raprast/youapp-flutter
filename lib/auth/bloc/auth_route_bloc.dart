import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRouteBloc extends Bloc<AuthRouteEvent, AuthRouteState> {
  AuthRouteBloc() : super(AuthRouteInitialState()) {
    on<AuthRouteRegisterEvent>((event, emit) {
      emit(AuthRouteRegisterState());
    });

    on<AuthRouteLoginEvent>((event, emit) {
      emit(AuthRouteLoginState());
    });
  }
}

abstract class AuthRouteState extends Equatable {
  const AuthRouteState();

  @override
  List<Object> get props => [];
}

class AuthRouteInitialState extends AuthRouteState {}

class AuthRouteLoginState extends AuthRouteState {}

class AuthRouteRegisterState extends AuthRouteState {}

abstract class AuthRouteEvent extends Equatable {
  const AuthRouteEvent();

  @override
  List<Object> get props => [];
}

class AuthRouteLoginEvent extends AuthRouteEvent {}

class AuthRouteRegisterEvent extends AuthRouteEvent {}
