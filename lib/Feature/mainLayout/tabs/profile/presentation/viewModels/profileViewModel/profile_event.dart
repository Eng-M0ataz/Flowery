

sealed class ProfileEvent {}

class GetLoggedUserDataEvent extends ProfileEvent {}

class EditProfileSubmitEvent extends ProfileEvent {}

class LoadUserDataEvent extends ProfileEvent {}


