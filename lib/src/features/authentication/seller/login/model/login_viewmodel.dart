// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, avoid_dynamic_calls

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/services/dio_utils.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';

// import 'package:device_info/device_info.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._ref) : super(LoginState());
  final Ref _ref;

  Future<ApiResponse> login({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );

    final String? existingUser = await HiveStorage.get(HiveKeys.phonenumber);

    try {
      final response = await _ref.read(serviceProvider).post(
            formData: formData,
            path: 'api/auth/login/',
          );

      var body = response.data;
      // List<dynamic> accounts = body['accounts'];
      // var firstAccount = accounts[0];
      if (response.statusCode == 200) {
        // && response.data['success'] == true
        await HiveStorage.put(HiveKeys.token, body['data']['access'] ?? '');
        // await HiveStorage.put(HiveKeys.address, body['address'] ?? '');
        // await HiveStorage.put(HiveKeys.phonenumber, body["phone"] ?? '');
        await HiveStorage.put(
          HiveKeys.userEmail,
          body['data']['user']['email'] ?? '',
        );

//check if verified...
        await HiveStorage.put(
          HiveKeys.license,
          body['data']['user']['is_verified'] ?? '',
        );

        await HiveStorage.put(
          HiveKeys.name,
          body['data']['user']['full_name'] ?? '',
        );
        await HiveStorage.put(
          HiveKeys.image,
          body['data']['user']['profile_picture'] ??
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        );
        await HiveStorage.put(
          HiveKeys.firstname,
          body['data']['user']['first_name'] ?? '',
        );
        await HiveStorage.put(
          HiveKeys.lastname,
          body['data']['user']['last_name'] ?? '',
        );

        await HiveStorage.put(HiveKeys.hasLoggedIn, true);

        if (existingUser == null) {
          await HiveStorage.put(HiveKeys.userEmail, formData['email'] ?? '');
          // await HiveStorage.put(HiveKeys.firstname, body['firstName'] ?? '');
        }

        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body['message'] ?? 'Login Successful',
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['message'] ?? 'Invalid Credentials',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loadStatus: Loader.error);

      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['message'] is List &&
          e.response!.data['message'].isNotEmpty) {
        // Join the error messages if there are multiple
        String errorMessage = e.response!.data['message'].join('\n');
        return ApiResponse(errorMessage: errorMessage);
      } else if (e.type == DioErrorType.badResponse ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        // Handle no internet connection or connection error here
        return ApiResponse(
          errorMessage: e.response!.data['message'] ??
              e.response!.data['mesage'] ??
              'Check your data connection / Connection error.',
        );
      } else {
        // Handle other DioErrors
        // return ApiResponse(errorMessage: "Connection error, Please try again.");
        return ApiResponse(
          errorMessage: e.response!.data['message'] ?? 'Please try again',
        );
      }
    }
  }

  // Future<ApiResponse> loginWithBioMetric() async {
  //   final isAuthenticated = await LocalAuthApi.authenticate();
  //   if (isAuthenticated) {
  //     //  String input = emailController.text.trim();

  //     final response = await login(formData: {
  //       // "email": HiveStorage.get(HiveKeys.userEmail),
  //       "Phone": HiveStorage.get(HiveKeys.phonenumber),
  //       "Password": HiveStorage.get(HiveKeys.userPassword),
  //     });
  //     if (response.successMessage.isNotEmpty) {
  //       return ApiResponse(successMessage: 'Login Successful');
  //     } else {
  //       return ApiResponse(errorMessage: 'Login not successful');
  //     }
  //   } else {
  //     return ApiResponse();
  //   }
  // }

  Future<ApiResponse> phoneChanged({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    try {
      final response = await _ref.read(serviceProvider).postWithToken(
            formData: formData,
            path: 'auth/reset/device',
          );
      var body = response.data;
      if (response.statusCode == 200) {
        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['message'] is String &&
          e.response!.data['message'].isNotEmpty) {
        return ApiResponse(
          errorMessage: e.response!.data['message'],
        );
      }

      return ApiResponse(
        errorMessage: e.response?.data['message'],
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }
}

class LoginState {
  // DataModel? newprofileModel;
  // String? id;
  // String? role;

  LoginState({
    this.loadStatus = Loader.idle,
    // this.newprofileModel,
    // this.role,
    // this.id
  });
  Loader loadStatus;

  LoginState copyWith({
    Loader? loadStatus,
    // DataModel? newprofileModel,
    // String? id,
    // String? role,
  }) =>
      LoginState(
        loadStatus: loadStatus ?? this.loadStatus,
        // newprofileModel: newprofileModel ?? this.newprofileModel,
        // id: id ?? this.id,
        // role: role ?? this.role
      );
}
