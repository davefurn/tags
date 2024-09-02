// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, avoid_dynamic_calls, avoid_catches_without_on_clauses, type_annotate_public_apis

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/services/dio_utils.dart';

class RegisterViewmodel extends StateNotifier<RegisterState> {
  RegisterViewmodel(this._reader)
      : super(
          RegisterState(
              // getProfile: [], myCountry: []
              // region: [],
              // bvnDetails: BvnDetails.fromJson({}),
              // findToken: FindToken.fromJson({}),
              ),
        );

  final Ref _reader;

  //
  Future<ApiResponse> signUp({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: 'api/auth/registration/',
          );
      var body = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        var token = body['data']['access']; // Extract the id from the response

        state = state.copyWith(
          loadStatus: Loader.loaded,
          token: token,
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
      state = state.copyWith(loadStatus: Loader.error);

      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['errors'] is List &&
          e.response!.data['message'].isNotEmpty) {
        // Join the error messages if there are multiple
        String errorMessage = e.response!.data['errors'].join('\n');
        return ApiResponse(errorMessage: errorMessage);
      } else if (e.type == DioErrorType.badResponse ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        // Handle no internet connection or connection error here
        return ApiResponse(
          errorMessage:
              e.response!.data['message'] ?? e.response!.data['error'],
          // "Check your data connection / Connection error."
        );
      } else {
        // Handle other DioErrors
        // return ApiResponse(errorMessage: "Connection error, Please try again.");
        return ApiResponse(errorMessage: e.response!.data['message']);
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  //veryEmail
  Future<ApiResponse> verifyEmail({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: '/api/auth/registration/verify-email/',
          );
      var body = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body['status'] ?? 'Success',
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['status'] ?? 'Incorrect details',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loadStatus: Loader.error);

      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['errors'] is List &&
          e.response!.data['message'].isNotEmpty) {
        // Join the error messages if there are multiple
        String errorMessage = e.response!.data['errors'].join('\n');
        return ApiResponse(errorMessage: errorMessage);
      } else if (e.type == DioErrorType.badResponse ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        // Handle no internet connection or connection error here
        return ApiResponse(
          errorMessage:
              e.response!.data['message'] ?? e.response!.data['error'],
          // "Check your data connection / Connection error."
        );
      } else {
        // Handle other DioErrors
        // return ApiResponse(errorMessage: "Connection error, Please try again.");
        return ApiResponse(errorMessage: e.response!.data['message']);
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  //resend email to verify
  Future<ApiResponse> resendOTP({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: '/api/auth/registration/resend-email/',
          );
      var body = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body['status'] ?? 'Success',
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['status'] ?? 'Incorrect details',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loadStatus: Loader.error);

      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['errors'] is List &&
          e.response!.data['message'].isNotEmpty) {
        // Join the error messages if there are multiple
        String errorMessage = e.response!.data['errors'].join('\n');
        return ApiResponse(errorMessage: errorMessage);
      } else if (e.type == DioErrorType.badResponse ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        // Handle no internet connection or connection error here
        return ApiResponse(
          errorMessage:
              e.response!.data['message'] ?? e.response!.data['error'],
          // "Check your data connection / Connection error."
        );
      } else {
        // Handle other DioErrors
        // return ApiResponse(errorMessage: "Connection error, Please try again.");
        return ApiResponse(errorMessage: e.response!.data['message']);
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  //forgot-password
  Future<ApiResponse> forgotPassword({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: '/api/mobile/auth/forgot-password',
            // additionalHeaders: HiveStorage.put(HiveKeys.token, value)
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['success'] == true) {
        // var id = body['id'];
        state = state.copyWith(
          loadStatus: Loader.loaded,
          // valId: id,
          // questionz: body['questions'] ,
          // lastName: body['data']['LastName'],
          // fullname: body['data']['FullName'],
          // midname: body['data']['MiddleName'],
          // gender: body['data']['Gender'],
        );
        return ApiResponse(
          successMessage: body['status'] ?? 'Success',
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['status'] ?? 'Incorrect details',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(
        errorMessage: e.response?.data['status'] ?? 'Connection Error',
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> changePassword({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: '/api/mobile/auth/change-password',
            // additionalHeaders: HiveStorage.put(HiveKeys.token, value)
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['success'] == true) {
        // var id = body['id'];
        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body['status'] ?? 'Success',
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['status'] ?? 'Incorrect details',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(
        errorMessage: e.response?.data['status'] ?? 'Connection Error',
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  //changePIN
  Future<ApiResponse> changePIN({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: '/api/mobile/auth/change-pin',
            // additionalHeaders: HiveStorage.put(HiveKeys.token, value)
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['success'] == true) {
        // var id = body['id'];
        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body['status'] ?? 'Success',
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['status'] ?? 'Incorrect details',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(
        errorMessage: e.response?.data['status'] ?? 'Connection Error',
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

//complete signup
  Future<ApiResponse> createCompany({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: 'api/company/create/',
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> body = response.data;
        if (body['status'] == 'success') {
          state = state.copyWith(
            loadStatus: Loader.loaded,
          );
          return ApiResponse(
            successMessage: 'Success',
          );
        } else {
          state = state.copyWith(
            loadStatus: Loader.error,
          );
          return ApiResponse(
            errorMessage: body['message'] ?? 'Failed',
          );
        }
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: 'Failed',
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loadStatus: Loader.error);

      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['errors'] is List &&
          e.response!.data['message'].isNotEmpty) {
        // Join the error messages if there are multiple
        String errorMessage = e.response!.data['errors'].join('\n');
        return ApiResponse(errorMessage: errorMessage);
      } else if (e.type == DioErrorType.badResponse ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        // Handle no internet connection or connection error here
        return ApiResponse(
          errorMessage:
              e.response!.data['message'] ?? e.response!.data['error'],
          // "Check your data connection / Connection error."
        );
      } else {
        // Handle other DioErrors
        // return ApiResponse(errorMessage: "Connection error, Please try again.");
        return ApiResponse(errorMessage: e.response!.data['message']);
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  //

  Future<ApiResponse> resetPass({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: 'api/auth/password/reset/',
          );
      var body = response.data;

      if (response.statusCode == 200 && response.data['status'] == 'success') {
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

      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> confirmResetPass({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: 'api/auth/password/reset/confirm/',
          );
      var body = response.data;

      if (response.statusCode == 200 && response.data['status'] == 'success') {
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

      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> forgotPasswordNew({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: 'auth/forgotpassword/mobile',
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['success'] == true) {
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
      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> resetPassWordMobile({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: 'auth/resetpassword/mobile',
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['success'] == true) {
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
      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getOTP({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            // path: "account/signup-otp/",
            path: 'auth/changepassword',
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['success'] == true) {
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
      return ApiResponse(
        error: e,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }
}

class RegisterState {
  // Add questions field

  // BvnDetails bvnDetails;
  // FindToken findToken;

  RegisterState({
    this.loadStatus = Loader.idle,
    this.token,
    this.regionname,
    // required this.getProfile,
    // required this.myCountry,
    this.valId,
    this.customerID,
    this.firstName,
    this.lastName,
    this.fullname,
    this.midname,
    this.gender,
    this.questions, // Initialize questions field

    // required this.findToken,
    // this.statelcd
  });
  Loader loadStatus;
  // CountriesModel? country;
  final String? regionname;
  final String? token;
  // final List<GetProfileModel> getProfile;
  // List<CountriesModel> myCountry;
  String? valId, firstName, lastName, fullname, gender, midname, customerID;
  Map<String, String>? questions;

  RegisterState copyWith({
    Loader? loadStatus,
    // List<Region>? region,
    String? regionname,
    // final List<GetProfileModel>? getProfile,
    // List<CountriesModel>? myCountry,
    Map<String, String>? questions, // Update copyWith method

    // CountriesModel? country,
    String? token,
    customerID,
    firstName,
    lastName,
    fullname,
    midname,
    gender,
    // BvnDetails? bvnDetails,
    // FindToken? findToken,
  }) =>
      RegisterState(
        token: token ?? this.token,
        customerID: customerID ?? this.customerID,
        // myCountry: myCountry ?? this.myCountry,
        questions: questions ?? this.questions, // Update questions field
        valId: valId ?? valId,
        // getProfile: getProfile ?? this.getProfile,
        loadStatus: loadStatus ?? this.loadStatus,
        regionname: regionname ?? this.regionname,
        // country: country ?? this.country,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fullname: fullname ?? this.fullname,
        midname: midname ?? this.midname,
        gender: gender ?? this.gender,
        // findToken: findToken ?? this.findToken,
        // bvnDetails: bvnDetails ?? this.bvnDetails
      );
}
