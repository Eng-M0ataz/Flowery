import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/signin/sign_in_view_model.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required SigninViewModel viewModel,
  }) : _viewModel = viewModel;

  final SigninViewModel _viewModel;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget._viewModel.rememberMe,
      onChanged: (val) {
        setState(() {});
        widget._viewModel.rememberMe = val ?? false;
      },
    );
  }
}
