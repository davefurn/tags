// ignore_for_file: deprecated_member_use, avoid_print, non_constant_identifier_names, unnecessary_lambdas, avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/services/dio_utils.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/authentication/seller/sign_up/model/catmodel.dart';
import 'package:tags/src/features/cart/model/checkout_model.dart';
import 'package:tags/src/features/home/models/view_model.dart';
import 'package:tags/src/features/orders/model/order_history.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this._reader)
      : super(
          ProfileState(
            // getProfile: GetProfileModel.fromJson({}),
            hasEnabledBiometricLogin:
                HiveStorage.get(HiveKeys.hasEnabledBiometricLogin) ?? false,
            // userProfile: UserProfile.fromJson({}),
            // user: UserProfile.fromJson({}),
            // dataBalance: DataBalance.fromJson({}),
          ),
        );

  final Ref _reader;
  Future<ApiResponse> refresh() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).refreshToken();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // Refresh token and access token are both received
        final newToken = response.data['data']['access'];
        final refresh = response.data['data']['refresh'];
        log(newToken);
        log(refresh);

        // Save the new access token and refresh token
        HiveStorage.put(HiveKeys.token, newToken);
        HiveStorage.put(HiveKeys.refreshToken, refresh);

        state = state.copyWith(
          loading: Loader.loaded,
        );
        return ApiResponse(
          successMessage: 'Token refreshed',
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        log(response.data.toString());
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getSearches({String? query}) async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      log(query.toString());
      final response = await _reader.read(serviceProvider).getWithToken(
            path: query != null ? 'api/search/?s=$query' : 'api/search/?s',
          );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        List<SearchResult> eventCat = (body['data']['results'] as List)
            .map((e) => SearchResult.fromJson(e))
            .toList();
        state = state.copyWith(
          loading: Loader.loaded,
          searchResults: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        log(response.data.toString());
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> delCart({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).deleteWithToken(
            formData: formData,
            path: '/api/cart/remove/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        // List<CartProducts> eventCat = (body['data'] as List)
        //     .map((e) => CartProducts.fromJson(e))
        //     .toList();
        // state = state.copyWith(
        //   loading: Loader.loaded,
        //   cartProducts: eventCat,
        // );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> editCart({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).put(
            formData: formData,
            path: '/api/cart/update/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        // List<CartProducts> eventCat = (body['data'] as List)
        //     .map((e) => CartProducts.fromJson(e))
        //     .toList();
        // state = state.copyWith(
        //   loading: Loader.loaded,
        //   cartProducts: eventCat,
        // );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> checkOut({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: '/api/checkout/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        OrderData orderData = OrderData.fromJson(
          body['data'],
        ); // Deserialize the entire 'data' object

        log(orderData.orderId);
        await saveOrder(orderData);

        state = state.copyWith(
          loading: Loader.loaded,
          orderData: orderData,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> initPay({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: '/api/payment/initiate/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        return ApiResponse(
          successMessage: body['message'],
          secret: body['data']['client_secret'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> postCart({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: '/api/cart/add/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        // List<CartProducts> eventCat = (body['data'] as List)
        //     .map((e) => CartProducts.fromJson(e))
        //     .toList();
        // state = state.copyWith(
        //   loading: Loader.loaded,
        //   cartProducts: eventCat,
        // );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  //

  Future<ApiResponse> delWishlist({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).deleteWithToken(
            formData: formData,
            path: '/api/wishlist/remove/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        // List<CartProducts> eventCat = (body['data'] as List)
        //     .map((e) => CartProducts.fromJson(e))
        //     .toList();
        // state = state.copyWith(
        //   loading: Loader.loaded,
        //   cartProducts: eventCat,
        // );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> postWishList({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loading: Loader.loading,
    // );

    try {
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: '/api/wishlist/add/',
          );
      log(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        // List<CartProducts> eventCat = (body['data'] as List)
        //     .map((e) => CartProducts.fromJson(e))
        //     .toList();
        // state = state.copyWith(
        //   loading: Loader.loaded,
        //   cartProducts: eventCat,
        // );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getAllOrderHistory() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/orders/',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        log(body.toString());

// Parsing the data field as OrderHistory
        OrderHistory orderHistory = OrderHistory.fromJson(body['data']);

// Access the list of OrderDetails from the orderHistory object
        List<OrderDetails> eventCat = orderHistory.results ?? [];

        state = state.copyWith(
          loading: Loader.loaded,
          orderdetails: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getAllWishlist() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/wishlist/list/',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        // Parsing the data field as CartMetadata
        PaginatedResult paginatedResult =
            PaginatedResult.fromJson(body['data']);

        // Access the list of CartProducts from the cartMetadata object
        List<ResultItem> eventCat = paginatedResult.results;
        state = state.copyWith(
          loading: Loader.loaded,
          resultItem: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getAllCart() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/cart/list/',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        // Parsing the data field as CartMetadata
        CartMetadata cartMetadata = CartMetadata.fromJson(body['data']);

        // Access the list of CartProducts from the cartMetadata object
        List<CartProducts> eventCat = cartMetadata.products ?? [];
        state = state.copyWith(
          loading: Loader.loaded,
          cartProducts: eventCat,
          cartMetadata: cartMetadata,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else if (response.statusCode == 401) {
        return ApiResponse(
          errorMessage: '401',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getAllBrandsProduct(String category) async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/category/$category/products/',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        List<BrandProduct> eventCat = (body['data']['results'] as List)
            .map((e) => BrandProduct.fromJson(e))
            .toList();
        state = state.copyWith(
          loading: Loader.loaded,
          productResponse: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  ///

  Future<ApiResponse> getAProduct(String slug) async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/product/$slug/',
          );
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        ViewMoreProduct eventCat = ViewMoreProduct.fromJson(body['data']);
        state = state.copyWith(
          loading: Loader.loaded,
          viewMoreProducts: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getAllBrands(String category) async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/category/$category/',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        List<Brand> eventCat = (body['data']['brands'] as List)
            .map((e) => Brand.fromJson(e))
            .toList();
        state = state.copyWith(
          loading: Loader.loaded,
          brandsNames: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> categories() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/categories/',
          );
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        List<ResultModel> eventCat = (body['data']['results'] as List)
            .map((e) => ResultModel.fromJson(e))
            .toList();
        state = state.copyWith(
          loading: Loader.loaded,
          categories: eventCat,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  //getComapny
  Future<ApiResponse> getCompany() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).getWithToken(
            path: 'api/company/',
          );
      if (response.statusCode == 200) {
        final Map<String, dynamic> body =
            response.data['data']; // Extract data object
        // CompanyModel company =
        //     CompanyModel.fromJson(body); // Map to CompanyModel

        await HiveStorage.put(HiveKeys.companyName, body['company_name'] ?? '');

        await HiveStorage.put(
          HiveKeys.companyEmail,
          body['company_email'] ?? '',
        );

        await HiveStorage.put(
          HiveKeys.companyPhone,
          body['company_phone'] ?? '',
        );

        await HiveStorage.put(HiveKeys.companyLogo, body['logo'] ?? '');

        await HiveStorage.put(HiveKeys.companyCover, body['cover'] ?? '');

        await HiveStorage.put(HiveKeys.companyCurrency, body['currency'] ?? '');

        await HiveStorage.put(
          HiveKeys.companyPaln,
          body['delivery_plan'] ?? '',
        );

        // List<CompanyModel> company = (body["categories"] as List)
        //     .map((e) => CompanyModel.fromJson(e))
        //     .toList();

        final List<String> company = (body['categories'] as List<dynamic>)
            .map((category) => category.toString())
            .toList();

        state = state.copyWith(
          loading: Loader.loaded,
          companies: company,
        );
        return ApiResponse(
          successMessage: response.data['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  //get all products
  Future<ApiResponse> getAllProducts() async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).get(
            path: 'api/home/',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        // {List<PopularCategoriz>? popularCat

        List<PopularCategoriz> allpopularCat =
            (body['data']['popular_categories'] as List)
                .map((e) => PopularCategoriz.fromJson(e))
                .toList();

        // best_selling
        List<BestSellingModel> allbestSelling =
            (body['data']['best_selling'] as List)
                .map((e) => BestSellingModel.fromJson(e))
                .toList();

        //today deals
        List<TodayDeal> todayDeals = (body['data']['today_deals'] as List)
            .map((e) => TodayDeal.fromJson(e))
            .toList();

        //categories
        //
        List<AllCategoriesModel> allCatz = (body['data']['categories'] as List)
            .map((e) => AllCategoriesModel.fromJson(e))
            .toList();

        // List<Product> allCatProductz =
        //     (body['data']['categories']['products'] as List)
        //         .map((e) => Product.fromJson(e))
        //         .toList();

        state = state.copyWith(
          loading: Loader.loaded,
          allNewCatz: allCatz,
          todayDealz: todayDeals,
          bestSelling: allbestSelling,
          popularCat: allpopularCat,
          // productz: allCatProductz,
        );
        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  //
  Future<ApiResponse> createItem({
    required Map<String, String> formData,
    required XFile image,
    required XFile image2,
  }) async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      final response = await _reader.read(serviceProvider).postMultipart(
            path: 'api/company/product/create/',
            files: [image, image2],
            formData: formData,
            pathName: 'images',
          );
      var body = json.decode(response.body);

      // var body = response.body;
      if (response.statusCode == 200 || response.statusCode == 201) {
        state = state.copyWith(
          loading: Loader.loaded,
          // eventModel: EventModel.fromJson(body['data']['event'])
        );

        return ApiResponse(
          successMessage: body['error'] ?? body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['error'] ?? body['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['errors'] is List &&
          e.response!.data['message'].isNotEmpty) {
        String errorMessage = e.response!.data['errors'] ??
            e.response!.data['message'].join('\n');
        return ApiResponse(errorMessage: errorMessage);
      } else if (e.type == DioErrorType.badResponse ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        return ApiResponse(
          errorMessage:
              e.response!.data['error'] ?? e.response!.data['message'],
        );
      } else {
        return ApiResponse(errorMessage: e.response!.data['message']);
      }
    } catch (e) {
      state = state.copyWith(
        loading: Loader.error,
      );
      rethrow;
    }
  }

  //api/company/create/
  Future<ApiResponse> updateCompany({
    required Map<String, String> formData,
    required XFile image,
    required XFile image2,
  }) async {
    state = state.copyWith(
      loading: Loader.loading,
    );

    try {
      // if (!files.existsSync()) {
      //   throw Exception("File not found");
      // }
      final response = await _reader.read(serviceProvider).putMultipart(
            path: 'api/company/update/',
            files: [image, image2],
            formData: formData,
            pathName: 'images', //images
          );
      var body = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        state = state.copyWith(
          loading: Loader.loaded,
          // eventModel: EventModel.fromJson(body['data']['event'])
        );

        return ApiResponse(
          successMessage: body['message'],
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: body['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);

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
        loading: Loader.error,
      );
      rethrow;
    }
  }

  ApiResponse _handleImageError(DioError e) {
    if (e.response != null && e.response!.statusCode == 413) {
      state = state.copyWith(
        loading: Loader.error,
      );
      return ApiResponse(
        errorMessage: 'Please use an image with a lesser MB size',
      );
    } else {
      state = state.copyWith(
        loading: Loader.error,
      );
      return ApiResponse(
        error: e,
      );
    }
  }
  //for business

  //for all account types

  Future<ApiResponse> updateProfile({
    required Map<String, dynamic> formData,
  }) async {
    try {
      final response = await _reader
          .read(serviceProvider)
          .put(path: 'api/profile/', formData: formData);
      if (response.statusCode == 200) {
        // await HiveStorage.put(HiveKeys.image, response.data);
        // var userProfile = UserProfile.fromJson(response.data['data']['user']);

        state = state.copyWith(
          loading: Loader.loaded,
          // userProfile: userProfile,
        );
        return ApiResponse(
          successMessage: 'Profile updated successfully',
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data['message'],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(
        loading: Loader.error,
      );
      return ApiResponse(
        error: e,
      );
    } catch (e) {
      state = state.copyWith(
        loading: Loader.error,
      );
      return ApiResponse(
        errorMessage: 'An error occurred while processing request',
      );
      //rethrow;
    }
  }

  // Future<ApiResponse> fetchUserProfile() async {
  //   try {
  //     final response = await _reader.read(networkProvider).getWithToken(
  //           path: 'api/profile/',
  //         );
  //     if (response.statusCode == 200) {
  //       await HiveStorage.put(HiveKeys.user, response.data);
  //       var userProfile = UserProfile.fromJson(response.data['data']['user']);

  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //         userProfile: userProfile,
  //       );
  //       return ApiResponse(
  //         successMessage: "User profile fetched successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["message"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //         errorMessage: 'An error occurred while processing request');
  //     //rethrow;
  //   }
  // }

  // Future<ApiResponse> getbalance() async {
  //   try {
  //     final response = await _reader.read(networkProvider).getWithToken(
  //           path: 'api/balance/',
  //         );
  //     if (response.statusCode == 200) {
  //       await HiveStorage.put(HiveKeys.user, response.data);

  //       // Parsing the response directly, assuming 'data' is the 'balance' map
  //       var data = DataBalance.fromJson(response.data['data']['balance']);

  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //         dataBalance: data,
  //       );
  //       return ApiResponse(
  //         successMessage: response.data['message'],
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["message"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //         errorMessage: 'An error occurred while processing request');
  //     //rethrow;
  //   }
  // }

  // Future<ApiResponse> bvnCheck({required Map<String, dynamic> formData}) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader
  //         .read(networkProvider)
  //         .postWithToken(path: "api/bvncheck/", formData: formData);
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       return ApiResponse(
  //         successMessage: response.data['message'],
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["message"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse> resetPin({
  //   required String otp,
  //   required String newPin,
  //   required String confirmPin,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader.read(networkProvider).postWithToken(
  //         path: "account/reset-pin/",
  //         formData: {
  //           "otp": otp,
  //           "new_pin": newPin,
  //           "confirm_new_pin": confirmPin
  //         });
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       await HiveStorage.put(HiveKeys.transactionPin, newPin);
  //       return ApiResponse(
  //         successMessage: "Pin reset successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["detail"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  ///Takes old and new passwords and sends via api for password change.
  ///returns custom ApiResponse Object

  // Future<ApiResponse> changePassword({
  //   required Map<String, Map<String, String>> formData,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader.read(serviceProvider).patch(
  //           formData: formData,
  //           path: 'api/changepassword/',
  //         );
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(loading: Loader.loaded);
  //       return ApiResponse(
  //         successMessage: 'Password reset successful',
  //       );
  //     } else {
  //       state = state.copyWith(loading: Loader.error);
  //       return ApiResponse(
  //         errorMessage: response.data['message'],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(loading: Loader.error);
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(loading: Loader.error);
  //     rethrow;
  //   }
  // }

  //

  // Future<ApiResponse> changePin({
  //   required String oldPin,
  //   required String newPin,
  //   required String confirmPin,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader
  //         .read(networkProvider)
  //         .postWithToken(path: "account/change-pin/", formData: {
  //       "old_pin": oldPin,
  //       "new_pin": newPin,
  //       "confirm_pin": confirmPin,
  //     });
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       await HiveStorage.put(
  //         HiveKeys.transactionPin,
  //         confirmPin,
  //       );
  //       return ApiResponse(
  //         successMessage: "Pin reset successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["detail"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse> sendResetOtp({
  //   required String email,
  //   required String type,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader
  //         .read(networkProvider)
  //         .postWithToken(path: "account/reset-otp/", formData: {
  //       "phone_number": email,
  //       "reset_type": type,
  //     });
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //         // otpResponse: OtpResponseModel.fromJson(response.data),
  //       );
  //       return ApiResponse(
  //         successMessage: response.data["detail"],
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["detail"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse> uploadProfilePic({required XFile files}) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader.read(serviceProvider).postMultipart(
  //           path: "api/changeimage/",
  //           formData: {},
  //           pathName: 'image',
  //           files: files,
  //         );
  //     var body = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       return ApiResponse(
  //         successMessage: "Image Uploaded Successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: body["message"],
  //       );
  //     }
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       errorMessage: "unable to update image please check the image selected ",
  //     );
  //   }
  // }

  Future<void> enableBiometricLogin(bool value) async {
    state = state.copyWith(
      hasEnabledBiometricLogin: !state.hasEnabledBiometricLogin,
    );
    await HiveStorage.put(HiveKeys.hasEnabledBiometricLogin, value);
  }

  //void for disable screenshot

  // void toggleVisibility(bool value) async {
  //   state = state.copyWith(isClicked: !state.isClicked);
  //   // isClicked = !isClicked; // Toggle the visibility
  //   // You may also want to update other related state here if necessary
  // }

  // void hideBalance(bool value) async {
  //   state = state.copyWith(hideBalance: value);
  //   await HiveStorage.put(HiveKeys.hideBalance, value);
  //   // Notify listeners about the change in state
  //   notifyListeners();
  // }
}

class ProfileState {
  // final List<NewAccount> account2;
  // final List<ProductTypeModel> productList;
  // OtpResponseModel? otpResponse;
  // final BankFlexUser? bankFlexUser;

  ProfileState({
    // required this.getProfile,
    required this.hasEnabledBiometricLogin,
    this.loading = Loader.idle,
    // required this.userProfile,
    this.orderData,
    this.company_name,
    this.viewMoreProducts,
    this.cartMetadata,
    this.company_email,
    this.brandsNames = const [],
    this.searchResults = const [],
    this.company_phone,
    this.company_logo,
    this.company_cover,
    this.company_currency,
    this.company_deliveryPlan,
    this.productResponse = const [],
    this.productz = const [],
    this.companies = const [],
    this.bestSelling = const [],
    this.categories = const [],
    this.popularCat = const [],
    this.todayDealz = const [],
    this.allNewCatz = const [],
    this.cartProducts = const [],
    this.resultItem = const [],
    this.orderdetails = const [],
    // required this.user,
    // this.otpResponse,
    // this.bankFlexUser,
  });
  final Loader loading;
  // final UserProfile userProfile;
  // final UserProfile user;
  // final DataBalance dataBalance;
  final bool hasEnabledBiometricLogin;
  // final GetProfileModel getProfile;
  final List<ResultModel> categories;
  // final List<CompanyModel> companies;
  final List<String>? companies;
  final List<PopularCategoriz> popularCat;
  final List<BestSellingModel> bestSelling;
  final List<BrandProduct> productResponse;
  final List<Brand> brandsNames;
  final List<TodayDeal> todayDealz;
  final List<CartProducts>? cartProducts;
  final List<ResultItem>? resultItem;
  final List<Product> productz;
  final List<AllCategoriesModel> allNewCatz;
  final List<SearchResult>? searchResults;
  final  List<OrderDetails>? orderdetails;
  final ViewMoreProduct? viewMoreProducts;
  final OrderData? orderData;
  final CartMetadata? cartMetadata;
  String? company_name;
  String? company_email;
  String? company_phone;
  String? company_logo;
  String? company_cover;
  String? company_currency;
  String? company_deliveryPlan;

  ProfileState copyWith({
    Loader? loading,
    final List<ResultModel>? categories,
    // final List<CompanyModel>?
    List<String>? companies,
    final List<PopularCategoriz>? popularCat,
    final List<Brand>? brandsNames,
    final ViewMoreProduct? viewMoreProducts,
    final OrderData? orderData,
    final CartMetadata? cartMetadata,
    final List<BrandProduct>? productResponse,
    final List<CartProducts>? cartProducts,
    final List<ResultItem>? resultItem,
  final  List<OrderDetails>? orderdetails,
    final List<SearchResult>? searchResults,
    final List<BestSellingModel>? bestSelling,
    final List<TodayDeal>? todayDealz,
    final List<AllCategoriesModel>? allNewCatz,
    final List<Product>? productz,
    // UserProfile? userProfile,
    // DataBalance? dataBalance,
    // AccountManager? accountManager,
    bool? hasEnabledBiometricLogin,
    String? company_name,
    company_email,
    company_phone,
    company_logo,
    company_cover,
    company_currency,
    company_deliveryPlan,
    // UserProfile? user,
    // OtpResponseModel? otpResponse,
  }) =>
      ProfileState(
        orderdetails: orderdetails ?? this.orderdetails,
        resultItem: resultItem ?? this.resultItem,
        viewMoreProducts: viewMoreProducts ?? this.viewMoreProducts,
        orderData: orderData ?? this.orderData,
        cartMetadata: cartMetadata ?? this.cartMetadata,
        productz: productz ?? this.productz,
        company_name: company_name ?? this.company_name,
        cartProducts: cartProducts ?? this.cartProducts,
        company_email: company_email ?? this.company_email,
        searchResults: searchResults ?? this.searchResults,
        company_phone: company_phone ?? this.company_phone,
        company_logo: company_logo ?? this.company_logo,
        company_cover: company_cover ?? this.company_cover,
        company_currency: company_currency ?? this.company_currency,
        company_deliveryPlan: company_deliveryPlan ?? this.company_deliveryPlan,
        companies: companies ?? this.companies,
        categories: categories ?? this.categories,
        popularCat: popularCat ?? this.popularCat,
        bestSelling: bestSelling ?? this.bestSelling,
        todayDealz: todayDealz ?? this.todayDealz,
        brandsNames: brandsNames ?? this.brandsNames,
        allNewCatz: allNewCatz ?? this.allNewCatz,
        // getProfile: getProfile ?? this.getProfile,
        // dataBalance: dataBalance ?? this.dataBalance,
        loading: loading ?? this.loading,
        productResponse: productResponse ?? this.productResponse,
        // userProfile: userProfile ?? this.userProfile,
        hasEnabledBiometricLogin:
            hasEnabledBiometricLogin ?? this.hasEnabledBiometricLogin,
        // user: user ?? this.user,
        // otpResponse: otpResponse ?? this.otpResponse,
      );
}
