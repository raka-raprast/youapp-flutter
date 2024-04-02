import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_flutter/models/error.dart';
import 'package:youapp_flutter/models/profile.dart';
import 'package:youapp_flutter/services/Profile_services.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileResetEvent>((event, emit) {
      emit(ProfileInitialState());
    });

    on<ProfileLoadingEvent>((event, emit) {
      emit(ProfileLoadingState());
    });

    on<ProfileCreateEvent>(
      (event, emit) async {
        emit(ProfileLoadingState());
        SharedPreferences pref = await SharedPreferences.getInstance();
        var data = pref.getString("authToken");
        if (data != null) {
          try {
            var response = await ProfileService.createProfile(data);
            emit(ProfileFetchState(profile: Profile.fromJson(response["data"])));
          } on DioException catch (e) {
            log(e.toString());
            var parsedResponse = jsonDecode(e.response.toString());
            emit(ProfileErrorState(error: ErrorHandler.fromJson(parsedResponse)));
          }
        }
      },
    );
    on<ProfileFetchEvent>(
      (event, emit) async {
        emit(ProfileLoadingState());
        SharedPreferences pref = await SharedPreferences.getInstance();
        var data = pref.getString("authToken");
        if (data != null) {
          try {
            var response = await ProfileService.getProfile(data);
            emit(ProfileFetchState(profile: Profile.fromJson(response["data"])));
          } on DioException catch (e) {
            log(e.toString());
            var parsedResponse = jsonDecode(e.response.toString());
            emit(ProfileErrorState(error: ErrorHandler.fromJson(parsedResponse)));
          }
        }
      },
    );
    on<ProfileUpdateEvent>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var data = pref.getString("authToken");
      if (data != null) {
        try {
          emit(ProfileLoadingState());
          var response = await ProfileService.updateProfile(
            data,
            profile: event.profile,
          );
          log(response.toString());
          emit(ProfileUpdateState());
          emit(ProfileFetchState(profile: Profile.fromJson(response["data"])));
        } on DioException catch (e) {
          var parsedResponse = jsonDecode(e.response.toString());
          emit(ProfileErrorState(error: ErrorHandler.fromJson(parsedResponse)));
        }
      }
    });
  }
}

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileFetchState extends ProfileState {
  final Profile profile;

  const ProfileFetchState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileLoadingState extends ProfileState {}

class ProfileUpdateState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final ErrorHandler error;

  const ProfileErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadingEvent extends ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class ProfileCreateEvent extends ProfileEvent {
  const ProfileCreateEvent();
}

class ProfileFetchEvent extends ProfileEvent {
  const ProfileFetchEvent();
}

class ProfileUpdateEvent extends ProfileEvent {
  final Profile profile;
  const ProfileUpdateEvent(this.profile);
}

class ProfileResetEvent extends ProfileEvent {}
