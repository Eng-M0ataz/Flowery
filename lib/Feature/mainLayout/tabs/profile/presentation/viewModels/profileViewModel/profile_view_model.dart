
import 'dart:io';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/edit_profile_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/get_logged_user_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/upload_photo_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  final TextEditingController editProfileFirstNameController =
      TextEditingController();

  final TextEditingController editProfileLastNameController =
      TextEditingController();

  final TextEditingController editProfileEmailController =
      TextEditingController();

  final TextEditingController editProfilePhoneController =
      TextEditingController();

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  File? selectedImageFile;
  String? initialImage;

  ProfileViewModel(this._getLoggedUserUseCase, this._editProfileUseCase,
      this._uploadPhotoUseCase)
      : super(ProfileState());


  Future<void> doIntend(ProfileEvent event) async {
    switch (event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();

      case EditProfileSubmitEvent():
        await _updateProfileWithOptionalImage();
      case LoadUserDataEvent():
        await _getLoggedUserData();

    }
  }

  Future<void> _getLoggedUserData() async {

    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getLoggedUserUseCase();
    switch (result) {
      case ApiSuccessResult<LoggedUserDataResponseEntity>():
        final response = result.data;
        onUserDataLoaded(response);
        emit(state.copyWith(
          isLoading: false,
          failure: null,
          loggedUserDataResponseEntity: response,
        ));


        break;
      case ApiErrorResult<LoggedUserDataResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }


  void onUserDataLoaded(LoggedUserDataResponseEntity response) {
    editProfileFirstNameController.text = response.user?.firstName ?? '';
    editProfileLastNameController.text = response.user?.lastName ?? '';
    editProfileEmailController.text = response.user?.email ?? '';
    editProfilePhoneController.text = response.user?.phone ?? '';
    initialImage = response.user?.photo;
  }

  Future<void> _updateProfileWithOptionalImage() async {
    if (!isFormValid()) {
      return;
    }

    emit(state.copyWith(isLoading: true, failure: null, editSuccess: false));

    try {
      if (selectedImageFile != null) {
        final uploadResult =
            await _uploadPhotoUseCase.invoke(selectedImageFile!);
        switch (uploadResult) {
          case ApiErrorResult<UploadPhotoResponseEntity>():
            emit(state.copyWith(
                isLoading: false,
                failure: uploadResult.failure,
                editSuccess: false));
            return;
          case ApiSuccessResult<UploadPhotoResponseEntity>():
            break;
        }
      }

      final request = EditProfileRequestEntity(
        firstName: editProfileFirstNameController.text.trim(),
        lastName: editProfileLastNameController.text.trim(),
        email: editProfileEmailController.text.trim(),
        phone: editProfilePhoneController.text
            .replaceAll(RegExp(r'[^\d+]'), '')
            .trim(),
      );

      final result = await _editProfileUseCase.invoke(request);

      switch (result) {
        case ApiSuccessResult<EditProfileResponseEntity>():
          emit(state.copyWith(
            isLoading: false,
            editSuccess: true,
            failure: null,
            editProfileResponseEntity: result.data,
          ));

          break;

        case ApiErrorResult<EditProfileResponseEntity>():
          emit(state.copyWith(
              isLoading: false, failure: result.failure, editSuccess: false));
          selectedImageFile = null;
          break;
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failure: null,
        editSuccess: false,
      ));
    }
  }

  void onImageSelected(File file) {
    selectedImageFile = file;
    emit(state.copyWith(selectedImage: file));
  }

  bool isFormValid() {
    return editProfileFormKey.currentState?.validate() ?? false;
  }

  void resetSuccessState() {
    emit(state.copyWith(editSuccess: false, failure: null));
  }

  @override
  Future<void> close() {
    editProfileFirstNameController.dispose();
    editProfileLastNameController.dispose();
    editProfileEmailController.dispose();
    editProfilePhoneController.dispose();
    return super.close();
  }

}
