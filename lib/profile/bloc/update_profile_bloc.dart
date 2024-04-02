import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_flutter/models/error.dart';
import 'package:youapp_flutter/models/profile.dart';
import 'package:youapp_flutter/services/profile_services.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitialState()) {
    on<UpdateProfileResetEvent>((event, emit) {
      emit(UpdateProfileInitialState());
    });

    on<UpdateProfileLoadingEvent>((event, emit) {
      emit(UpdateProfileLoadingState());
    });

    on<UpdateProfileChangeProfileImageEvent>(
      (event, emit) async {
        emit(UpdateProfileLoadingState());
        SharedPreferences pref = await SharedPreferences.getInstance();
        var data = pref.getString("authToken");
        if (data != null) {
          try {
            var response = await ProfileService.changeImage(file: event.file, token: data);
            emit(UpdateProfileUpdateImageState(profile: Profile.fromJson(response["data"])));
          } on DioException catch (e) {
            var parsedResponse = jsonDecode(e.response.toString());
            emit(UpdateProfileErrorState(error: ErrorHandler.fromJson(parsedResponse)));
          }
        }
      },
    );
  }
}

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileInitialState extends UpdateProfileState {}

class UpdateProfileUpdateImageState extends UpdateProfileState {
  final Profile profile;

  const UpdateProfileUpdateImageState({required this.profile});

  @override
  List<Object?> get props => [];
}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {
  final ErrorHandler error;

  const UpdateProfileErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileLoadingEvent extends UpdateProfileEvent {}

class UpdateProfileInitialEvent extends UpdateProfileEvent {}

class UpdateProfileChangeProfileImageEvent extends UpdateProfileEvent {
  final File file;
  const UpdateProfileChangeProfileImageEvent(this.file);
}

class UpdateProfileResetEvent extends UpdateProfileEvent {}
