import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/edit_profile_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/get_logged_user_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/upload_photo_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'profile_view_model_test.mocks.dart';

@GenerateMocks([
  GetLoggedUserUseCase,
  EditProfileUseCase,
  UploadPhotoUseCase,
])
void main() {
  late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;

  late LoggedUserDataResponseEntity loggedUserDataResponseEntity;
  late ApiResult<LoggedUserDataResponseEntity> loggedUserResult;

  setUpAll(() {
    mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();

    loggedUserDataResponseEntity = LoggedUserDataResponseEntity(
      message: "ok",
      user: const LoggedUserEntity(
        id: "1",
        firstName: "Ahmed",
        lastName: "Rajeh",
        email: "ahmed@test.com",
        phone: "01000000000",
        photo: "photo.png",
      ),
    );
    loggedUserResult = ApiSuccessResult<LoggedUserDataResponseEntity>(
        data: loggedUserDataResponseEntity);
  });

  group("ProfileViewModel Tests", () {
    blocTest<ProfileViewModel, ProfileState>(
      "should load logged user data",
      build: () {
        provideDummy<ApiResult<LoggedUserDataResponseEntity>>(loggedUserResult);
        when(mockGetLoggedUserUseCase())
            .thenAnswer((_) async => loggedUserResult);
        return ProfileViewModel(
          mockGetLoggedUserUseCase,
          mockEditProfileUseCase,
          mockUploadPhotoUseCase,
        );
      },
      act: (viewModel) async {
        await viewModel.doIntend(GetLoggedUserDataEvent());
      },
      expect: () => [
        isA<ProfileState>().having((s) => s.isLoading, "isLoading", true),
        isA<ProfileState>()
            .having((s) => s.isLoading, "isLoading", false)
            .having((s) => s.loggedUserDataResponseEntity, "loggedUser",
                loggedUserDataResponseEntity),
      ],
      verify: (viewModel) {
        verify(mockGetLoggedUserUseCase()).called(1);
      },
    );
  });
}
