import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/viewModels/profileViewModel/profile_view_model.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/widgets/editProfile/form/edit_profile_form.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt.get<ProfileViewModel>()..doIntend(GetLoggedUserDataEvent()),
        child: EditProfileForm());
  }
}
