import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isUpdating;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;
  final EditProfileResponseEntity? editProfileResponseEntity;
  final File? selectedImage;
  final bool editSuccess;
  final bool isDataChanged;

  const ProfileState({
    this.isLoading = true,
    this.isUpdating = false,
    this.failure,
    this.loggedUserDataResponseEntity,
    this.editProfileResponseEntity,
    this.selectedImage,
    this.editSuccess = false,
    this.isDataChanged = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    isUpdating,
    failure,
    loggedUserDataResponseEntity,
    editProfileResponseEntity,
    selectedImage,
    editSuccess,
    isDataChanged,
  ];

  ProfileState copyWith({
    bool? isLoading,
    bool? isUpdating,
    Failure? failure,
    LoggedUserDataResponseEntity? loggedUserDataResponseEntity,
    EditProfileResponseEntity? editProfileResponseEntity,
    File? selectedImage,
    bool? editSuccess,
    bool? isDataChanged,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
      loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
      editProfileResponseEntity:
      editProfileResponseEntity ?? this.editProfileResponseEntity,
      selectedImage: selectedImage ?? this.selectedImage,
      editSuccess: editSuccess ?? this.editSuccess,
      isDataChanged: isDataChanged ?? this.isDataChanged,
    );
  }
}
