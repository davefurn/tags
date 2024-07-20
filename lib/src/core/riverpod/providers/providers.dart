import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tags/src/core/services/moticar_backend.dart';
import 'package:tags/src/core/widget/imagepicker.dart';
import 'package:tags/src/features/authentication/seller/login/model/login_viewmodel.dart';
import 'package:tags/src/features/authentication/seller/sign_up/model/profile_viewmodel.dart';
import 'package:tags/src/features/authentication/seller/sign_up/model/register_view.dart';

final serviceProvider = Provider((_) => AgencyBackEnd(Dio()));

///
// final imagePickerService = Provider((ref) => AgencyImagePicker(ImagePicker()));

final pinProvider = StateProvider.autoDispose<List>((ref) => []);

final imagePickerService = Provider((ref) => TagImagePicker(ImagePicker()));

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
  LoginViewModel.new,
);

final registerViewmodelProvider =
    StateNotifierProvider<RegisterViewmodel, RegisterState>(
  RegisterViewmodel.new,
);

final profileProvider = StateNotifierProvider<ProfileViewModel, ProfileState>(
  ProfileViewModel.new,
);

final isDarkModeEnabledProvider = StateProvider((ref) => false);
