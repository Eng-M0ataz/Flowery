import 'dart:io';

sealed class ProfileEvent {}

class GetLoggedUserDataEvent extends ProfileEvent {}

class EditProfileSubmitEvent extends ProfileEvent {}

class LoadUserDataEvent extends ProfileEvent {}

class OnImageSelectedEvent extends ProfileEvent {
  final File file;
  OnImageSelectedEvent({required this.file});
}

class ResetSuccessStateEvent extends ProfileEvent {}

class CloseEvent extends ProfileEvent {}
