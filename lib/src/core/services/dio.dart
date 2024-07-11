// // ignore_for_file: deprecated_member_use

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';


// import '../widgets/flushbar.dart';

// class DioClient extends ChangeNotifier {
//   late final Dio _dio;
//   // final String? token;
//   // final String? baseUrl;

//   // DioClient(this._dio, this.baseUrl, {this.token}) {
//   //   _dio
//   //     ..options.baseUrl = baseUrl ?? ""
//   //     ..options.connectTimeout = Constant.connectionTimeout
//   //     ..options.receiveTimeout = Constant.receiveTimeout
//   //     ..options.responseType = ResponseType.json
//   //     ..options.headers = {
//   //       "Accept": "*/*",
//   //       "Content-Type": "application/json",
//   //       "Authorization": "Basic $token",
//   //     };
//   // }

//   Future<Response> get(context, String url,
//       {Map<String, dynamic>? queryParameters,
//       Options? options,
//       CancelToken? cancelToken,
//       ProgressCallback? onReceiveProgress,
//       dynamic method}) async {
//     try {
//       final Response response = await _dio.get(
//         url,
//         queryParameters: queryParameters,
//         options: Options(headers: {"Authorization": "Basic $token"}),
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );

//       return response;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       // showTopSnackBar(
//       //   Overlay.of(context),
//       //   CustomSnackBar.error(
//       //     message: errorMessage,
//       //   ),
//       // );
//       Alert.showNotificationError(
//         message: errorMessage,
//         context: context,
//         notificationType: 1,
//       );
//       throw errorMessage;
//     }
//   }

//   Future<Response> post(context, String url,
//       {data,
//       Map<String, dynamic>? queryParameters,
//       Options? options,
//       CancelToken? cancelToken,
//       ProgressCallback? onSendProgress,
//       ProgressCallback? onReceiveProgress,
//       callback}) async {
//     try {
//       final Response response = await _dio.post(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(headers: {
//           // "Authorization": "Bearer $token"
//           "Content-Type": "application/json",
//           "Accept": "application/json"
//         }),
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );

//       // print(response);

//       return response;
//     } on DioError catch (e) {
//       print('chec');

//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       print(errorMessage);
//       // showTopSnackBar(
//       //   Overlay.of(context),
//       //   CustomSnackBar.error(
//       //     message: errorMessage,
//       //   ),
//       // );

//       Alert.showNotificationError(
//         message: errorMessage,
//         context: context,
//         notificationType: 1,
//       );

//       throw errorMessage;
//     }
//   }
// }

// class DioExceptions implements Exception {
//   String message = '';

//   DioExceptions.fromDioError(DioError dioError) {
//     print('jfjjf ');
//     // print(dioError.response!.statusMessage);
//     print(dioError.response!.data['message']);
//     // print(dioError.type);
//     // print(dioError.response?.statusCode);
//     // print(dioError.response);

//     // EasyLoading.dismiss();
//     switch (dioError.type) {
//       case DioErrorType.cancel:
//         message = "Request to server was cancelled";
//         break;
//       case DioErrorType.connectionTimeout:
//         message = "Connection timeout with server";
//         break;
//       case DioErrorType.receiveTimeout:
//         message = "Receive timeout in connection with server";
//         break;
//       case DioErrorType.badResponse:
//         message = _handleError(
//           dioError.response?.statusCode,
//           dioError.response?.data,
//         );
//         break;
//       case DioErrorType.sendTimeout:
//         message = "Send timeout in connection with server";
//         break;
//       case DioErrorType.unknown:
//         if (dioError.message!.contains("SocketException")) {
//           message = 'No Internet Connection';
//           break;
//         }
//         message = "Unexpected error occurred";
//         break;
//       default:
//         message = "Something went wrong";
//         break;
//     }
//   }

//   String _handleError(int? statusCode, dynamic error) {
//     switch (statusCode) {
//       case 400:
//         print('400');
//         print(error.runtimeType);
//         print(error['message']);
//         if (error["message"].toString().isNotEmpty) {
//           return error["message"];
//         }
//         //display the first error
//         return error['errors'].values.first[0];
//       case 401:
//         return error['message'];
//       case 403:
//         return error['message'];
//       case 404:
//         return error['message'];
//       case 409:
//         return error['message'];
//       case 422:
//         return error["errors"].values.first[0];
//       case 500:
//         // print(jsonDecode(error));
//         print('500 error');
//         print(error);
//         var error2 = jsonDecode(error);

//         if (error2.containsKey('message')) {
//           return error2['message'];
//         } else {
//           return "Error, Please try again";
//         }

//       case 502:
//         return 'Bad gateway';
//       default:
//         return 'Oops something went wrong';
//     }
//   }

//   @override
//   String toString() => message;
// }
