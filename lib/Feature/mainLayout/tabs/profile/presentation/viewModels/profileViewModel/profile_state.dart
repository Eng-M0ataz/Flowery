import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;
  final EditProfileResponseEntity? editProfileResponseEntity;
  final File? selectedImage;
  final bool editSuccess;

  const ProfileState({
    this.isLoading = true,
    this.failure,
    this.loggedUserDataResponseEntity,
    this.editProfileResponseEntity,
    this.selectedImage,
    this.editSuccess = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        failure,
        loggedUserDataResponseEntity,
        editProfileResponseEntity,
        selectedImage,
        editSuccess,
      ];

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    LoggedUserDataResponseEntity? loggedUserDataResponseEntity,
    EditProfileResponseEntity? editProfileResponseEntity,
    File? selectedImage,
    bool? editSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
          loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
      editProfileResponseEntity:
          editProfileResponseEntity ?? this.editProfileResponseEntity,
      selectedImage: selectedImage ?? this.selectedImage,
      editSuccess: editSuccess ?? this.editSuccess,
    );
  }
}
