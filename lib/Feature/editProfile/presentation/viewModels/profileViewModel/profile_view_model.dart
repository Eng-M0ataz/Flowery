import 'dart:io';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/useCases/edit_profile_use_case.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/useCases/get_logged_user_use_case.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/useCases/upload_photo_use_case.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_state.dart';
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
      : super(ProfileState()){
    _addListeners();
  }

  Future<void> doIntend(ProfileEvent event) async {
    switch (event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();
      case EditProfileSubmitEvent():
        await _updateProfileWithOptionalImage();
      case LoadUserDataEvent():
        await _getLoggedUserData();
      case OnImageSelectedEvent():
        _onImageSelected(event.file);
        _onDataChanged();
        break;
      case ResetSuccessStateEvent():
        _resetSuccessState();
      case CloseEvent():
        await _close();
    }
  }

  Future<void> _getLoggedUserData() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getLoggedUserUseCase();
    switch (result) {
      case ApiSuccessResult<LoggedUserDataResponseEntity>():
        final response = result.data;
        _onUserDataLoaded(response);
        emit(state.copyWith(
          isLoading: false,
          failure: null,
          loggedUserDataResponseEntity: response,
          isDataChanged: false,
          selectedImage: null,
        ));

        break;
      case ApiErrorResult<LoggedUserDataResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }

  void _onUserDataLoaded(LoggedUserDataResponseEntity response) {
    _removeListeners();
    editProfileFirstNameController.text = response.user?.firstName ?? '';
    editProfileLastNameController.text = response.user?.lastName ?? '';
    editProfileEmailController.text = response.user?.email ?? '';
    editProfilePhoneController.text = response.user?.phone ?? '';
    initialImage = response.user?.photo;
    selectedImageFile = null;
    _addListeners();
  }

  Future<void> _updateProfileWithOptionalImage() async {
    if (!_isFormValid()) return;

    emit(state.copyWith(isUpdating: true,));

    try {
      final uploadSuccess = await _handleImageUploadIfNeeded();
      if (!uploadSuccess) return;

      await _updateProfileData();
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        failure: null,
        editSuccess: false,
      ));
    }
  }

  Future<bool> _handleImageUploadIfNeeded() async {
    if (selectedImageFile == null) return true;

    final uploadResult = await _uploadPhotoUseCase.invoke(selectedImageFile!);
    switch (uploadResult) {
      case ApiErrorResult<UploadPhotoResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          failure: uploadResult.failure,
          editSuccess: false,
        ));
        return false;

      case ApiSuccessResult<UploadPhotoResponseEntity>():
        return true;
    }
  }

  Future<void> _updateProfileData() async {
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
          isUpdating: false,
          editSuccess: true,
          failure: null,
          editProfileResponseEntity: result.data,
        ));
        break;

      case ApiErrorResult<EditProfileResponseEntity>():
        emit(state.copyWith(
          isUpdating: false,
          failure: result.failure,
          editSuccess: false,
        ));
        selectedImageFile = null;
        break;
    }
  }

  void _onImageSelected(File file) {
    selectedImageFile = file;
    emit(state.copyWith(selectedImage: file));
  }
  void _onDataChanged() {
    final initialData = state.loggedUserDataResponseEntity?.user;
    if (initialData == null) {
      return;
    }

    final bool isFirstNameChanged =
        editProfileFirstNameController.text.trim() !=
            (initialData.firstName ?? '');
    final bool isLastNameChanged =
        editProfileLastNameController.text.trim() !=
            (initialData.lastName ?? '');
    final bool isEmailChanged =
        editProfileEmailController.text.trim() !=
            (initialData.email ?? '');
    final bool isPhoneChanged =
        editProfilePhoneController.text.trim() !=
            (initialData.phone ?? '');

    final bool isImageChanged = state.selectedImage != null;

    final bool hasChanged = isFirstNameChanged ||
        isLastNameChanged ||
        isEmailChanged ||
        isPhoneChanged ||
        isImageChanged;

    if (hasChanged != state.isDataChanged) {
      emit(state.copyWith(isDataChanged: hasChanged));
    }
  }

  void _addListeners() {
    editProfileFirstNameController.addListener(_onDataChanged);
    editProfileLastNameController.addListener(_onDataChanged);
    editProfileEmailController.addListener(_onDataChanged);
    editProfilePhoneController.addListener(_onDataChanged);
  }

  void _removeListeners() {
    editProfileFirstNameController.removeListener(_onDataChanged);
    editProfileLastNameController.removeListener(_onDataChanged);
    editProfileEmailController.removeListener(_onDataChanged);
    editProfilePhoneController.removeListener(_onDataChanged);
  }

  bool _isFormValid() {
    return editProfileFormKey.currentState?.validate() ?? false;
  }

  void _resetSuccessState() {
    emit(state.copyWith(editSuccess: false, failure: null));
  }

  Future<void> _close() {
    _removeListeners();
    editProfileFirstNameController.dispose();
    editProfileLastNameController.dispose();
    editProfileEmailController.dispose();
    editProfilePhoneController.dispose();
    return super.close();
  }
}
