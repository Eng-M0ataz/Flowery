import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_state.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_view_model.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/build_app_bar.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/build_email_field.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/build_first_and_last_name_field.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/build_gender_filed.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/build_password.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/build_phone_field.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/profile_image/profile_image_picker_widget.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final ProfileViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileViewModel>();
    viewModel.doIntend(LoadUserDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.doIntend(CloseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
        listener: (context, state) {
      if (state.failure != null && !state.isLoading) {
        DialogueUtils.showMessage(
          context: context,
          message: state.failure!.errorMessage,
          posActionName: LocaleKeys.ok.tr(),
          posAction: () {
            viewModel.doIntend(ResetSuccessStateEvent());
            context.pop();
          },
        );
      }

      if (state.editSuccess && !state.isLoading) {
        DialogueUtils.showMessage(
          context: context,
          message: LocaleKeys.profile_updated.tr(),
          title: LocaleKeys.success.tr(),
          posActionName: LocaleKeys.ok.tr(),
          posAction: () {
            viewModel.doIntend(ResetSuccessStateEvent());
            context.pop();
          },
        );
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: BuildAppBar(context: context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.editProfileFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMd_20),
                  child: AutofillGroup(
                      child: Column(
                    children: [
                      const SizedBox(height: AppSizes.spaceBetweenItems_8),
                      ProfileImagePickerWidget(
                        size: AppSizes.profileImageSize_85,
                        initialImageUrl:
                            state.selectedImage?.path ?? viewModel.initialImage,
                        onImageSelected: (file) {
                          if (file != null) {
                            viewModel
                                .doIntend(OnImageSelectedEvent(file: file));
                          }
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_24),
                      BuildFirstAndLastNameField(
                          firstNameController:
                              viewModel.editProfileFirstNameController,
                          secondNameController:
                              viewModel.editProfileLastNameController),
                      const SizedBox(height: AppSizes.spaceBetweenItems_24),
                      BuildEmailField(
                          controller: viewModel.editProfileEmailController),
                      const SizedBox(height: AppSizes.spaceBetweenItems_24),
                      BuildPhoneField(
                          controller: viewModel.editProfilePhoneController),
                      const SizedBox(height: AppSizes.spaceBetweenItems_24),
                      BuildPasswordField(
                        onChangePressed: () {
                          context.pushNamed("/changePassword");
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_24),
                      BuildGenderField(
                        selectedGender:
                            state.loggedUserDataResponseEntity?.user?.gender ??
                                AppConstants.male,
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_32),
                      CustomElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          viewModel.doIntend(EditProfileSubmitEvent());
                        },
                        isLoading: state.isLoading,
                        widget: Text(LocaleKeys.update.tr()),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_16),
                    ],
                  )),
                ),
              ),
            ),
          ));
    });
  }
}
