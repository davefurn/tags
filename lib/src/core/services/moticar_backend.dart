// ignore_for_file: override_on_non_overriding_member, deprecated_member_use, avoid_print, prefer_single_quotes

import 'dart:developer';
// import 'package:dio/adapter.dart';
// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tags/src/core/services/moticar_network.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
// import '../utils/constants.dart';

// //up endpoint
String baseUrl = 'https://dev.api.tagsmarketplace.com/';
// Constant.baseUrl;

class AgencyBackEnd implements AgencyNetwork {
  AgencyBackEnd(this._dio) {
    _dio.options.baseUrl = baseUrl;

    // Add logging for requests and responses
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

    // Add the token refresh interceptor
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (error, handler) async {
    //       if (error.response?.statusCode == 401) {
    //         // Token might be expired, refresh it
    //         try {
    //           final refreshToken = await _refreshToken();
    //           String? token = HiveStorage.get(HiveKeys.token);

    //           // If refresh token is null or token is empty, break
    //           if (refreshToken == null || refreshToken == '') {
    //             return handler.reject(error); // Stop retrying if refresh fails
    //           }

    //           // Update the headers with the new token and retry the request
    //           final options = error.requestOptions;
    //           options.headers["Authorization"] = 'Bearer $token';

    //           // Retry the request
    //           final response = await _dio.request(
    //             options.path,
    //             options: Options(
    //               method: options.method,
    //               headers: options.headers,
    //             ),
    //           );
    //           return handler.resolve(response);
    //         } on DioError catch (refreshError) {
    //           if (refreshError.response?.statusCode == 400 ||
    //               refreshError.response?.statusCode == 401) {
    //             // Refresh token failed, break the flow
    //             log('Refresh token failed with status: ${refreshError.response?.statusCode}');

    //             return handler.reject(refreshError); // Stop retrying
    //           } else {
    //             log(refreshError.toString());
    //             log('Making refresh token null');
    //             HiveStorage.put(HiveKeys.refreshToken, null);
    //             return handler.reject(error); // Forward original error
    //           }
    //         }
    //       }
    //       return handler.reject(error); // Forward error if not 401
    //     },
    //   ),
    // );

    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
  }

  late final Dio _dio;

  Future<Response> put({
    required Map<String, dynamic> formData,
    required String path,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);
    try {
      final data = await _dio.put(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      log(data.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> get({
    required String path,
  }) async {
    try {
      final response = await _dio.get(
        path,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      log(response.toString());
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> getWithToken({
    required String path,
    Map<String, dynamic>? formData,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);
    log(token.toString());
    try {
      final response = await _dio.get(
        path,
        queryParameters: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                token == '' || token == null ? '' : 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> logout() async {}

  @override
  Future<Response> post({
    required Map<String, dynamic> formData,
    required String path,
  }) async {
    // print('logging in');
    try {
      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': "Bearer $token"
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      print('error');
      final errorMessage = DioExceptions.fromDioError(e).toString();

      print(errorMessage);

      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> newpost({
    required FormData formData,
    required String path,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);
    try {
      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                token == '' || token == null ? '' : 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future putMultipart({
    required Map<String, String> formData,
    required String path,
    required String pathName,
    // required XFile files,
    required List<XFile> files,
    //String? pathName2,
  }) async {
    String token = HiveStorage.get(HiveKeys.token);
    var request = http.MultipartRequest('PUT', Uri.parse("$baseUrl$path"));
    request.fields.addAll(formData);
    request.headers.addAll(
      {
        // "Accept": "application/json",
        'Content-type': 'multipart/form-data',
        'Authorization': token == '' ? '' : 'Bearer $token',
      },
    );
    // request.files.add(await http.MultipartFile.fromPath(pathName, files.path));
    for (final file in files) {
      request.files.add(await http.MultipartFile.fromPath(pathName, file.path));
    }
    http.Response resp = await http.Response.fromStream(await request.send());
    log(resp.toString());
    return resp;
  }

  @override
  // Future postMultipart({
  //   required String path,
  //   required List<XFile> files, // Changed to List<XFile>
  //   required Map<String, String> formData,
  //   required String pathName,
  // }) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(baseUrl + path));
  //   formData.forEach((key, value) {
  //     request.fields[key] = value;
  //   });

  //   for (var file in files) {
  //     request.files.add(await http.MultipartFile.fromPath(pathName, file.path));
  //   }

  //   var response = await request.send();
  //   // return await http.Response.fromStream(response);
  //   log(response.toString());
  //   return response;
  // }
  Future<http.Response> postMultipart({
    required Map<String, String> formData,
    required String path,
    required String pathName,
    required List<XFile> files,
  }) async {
    String token = HiveStorage.get(HiveKeys.token);
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl$path"));
    request.fields.addAll(formData);
    request.headers.addAll({
      // "Accept": "application/json",
      'Content-type': 'multipart/form-data',
      'Authorization': token == '' ? '' : 'Bearer $token',
    });

    // Loop through each XFile object in the 'files' list
    for (final file in files) {
      request.files.add(await http.MultipartFile.fromPath(pathName, file.path));
    }

    http.Response resp = await http.Response.fromStream(await request.send());
    log(resp.toString());
    return resp;
  }

  @override
  Future postPic({
    // required Map<String, String> formData,
    required String path,
    required String pathName,
    required XFile files,
  }) async {
    String token = HiveStorage.get(HiveKeys.token);
    var request = http.MultipartRequest('POST', Uri.parse("$baseUrl$path"));
    // request.fields.addAll(formData);
    request.headers.addAll(
      {
        'Accept': 'application/json',
        'Authorization': token == '' ? '' : 'Bearer $token',
      },
    );
    request.files.add(await http.MultipartFile.fromPath(pathName, files.path));
    http.Response resp = await http.Response.fromStream(await request.send());
    log(resp.toString());
    return resp;
  }

  @override
  Future<Response> deleteWithToken({
    required String path,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);

    try {
      final data = await _dio.delete(
        path,
        data: formData, // Optional body data (some APIs allow data in DELETE)
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                token == '' || token == null ? '' : 'Bearer $token',
          },
        ),
      );
      log(data.statusCode.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> postWithToken({
    required String path,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);

    try {
      final data = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                token == '' || token == null ? '' : 'Bearer $token',
          },
        ),
      );
      log(data.statusCode.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> postMyToken({
    required String path,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);

    try {
      final data = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization':
                token == '' || token == null ? '' : 'Bearer $token',
          },
        ),
      );
      log(data.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> refreshToken() async {
    // Implement the logic for refreshing the token
    try {
      final refreshToken =
          HiveStorage.get(HiveKeys.refreshToken); // Get stored refresh token
      String? token = HiveStorage.get(HiveKeys.token); // Get stored token
      final response = await _dio.post(
        'api/auth/token/refresh/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                token == '' || token == null ? '' : 'Bearer $token',
          },
        ),
      );
      log(response.toString());
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later',
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }
  //   @override
  //     Future<Response> getUserProfile({String? authToken, dynamic id}) async {
  //   try {
  //     final response = await _dio.post(
  //       "bankone/",
  //       data: ApiRequest(
  //           method: "GET",
  //           url: baseUrl +
  //               "Account/GetAccountsByCustomerId/2?authtoken=$authToken&customerId=$id",
  //           payload: {}).toJson(),
  //       options: Options(
  //         headers: {
  //           "Accept": "application/json",
  //           "Content-Type": "application/json",
  //         },
  //       ),
  //     );
  //     log(response.toString());
  //     return response;
  //   } on DioError catch (e) {
  //     if (e.response != null && e.response!.statusCode! >= 500) {
  //       e.response!.data = {
  //         'message': 'Problem contacting server. Please try again later'
  //       };
  //       rethrow;
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    // print('jfjjf ');
    // // print(dioError);
    // print(dioError.type);
    // print(dioError.response?.statusCode);
    // print(dioError.response);

    // EasyLoading.dismiss();
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to server was cancelled';
        break;
      case DioErrorType.connectionTimeout:
        message = 'Connection timeout with server';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Receive timeout in connection with server';
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with server';
        break;
      case DioErrorType.unknown:
        if (dioError.message!.contains('SocketException')) {
          message = 'No Internet Connection';
          break;
        }
        message = 'Unexpected error occurred';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }
  String message = '';

  String _handleError(int? statusCode, error) {
    switch (statusCode) {
      case 400:
        if (error is Map<String, dynamic>) {
          if (error.containsKey('message') &&
              error['message'].toString().isNotEmpty) {
            return error['message'];
          } else if (error.containsKey('errors')) {
            final errors = error['errors'] as Map<String, dynamic>;
            if (errors.isNotEmpty) {
              return errors.values.first[0];
            }
          }
        }
        return 'Bad request';
      case 401:
      case 403:
      case 404:
      case 409:
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          return error['message'];
        }
        return 'Unauthorized';
      case 422:
        if (error is Map<String, dynamic> &&
            error.containsKey('non_field_errors')) {
          final nonFieldErrors = error['non_field_errors'] as List<dynamic>;
          if (nonFieldErrors.isNotEmpty) {
            return nonFieldErrors[0];
          }
        }
        return 'Unprocessable Entity';
      case 500:
        print('500 error');
        print(error);
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          return error['message'];
        }
        return 'Internal Server Error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
