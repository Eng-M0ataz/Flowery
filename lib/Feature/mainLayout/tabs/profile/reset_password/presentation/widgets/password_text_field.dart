import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget{
  final String hintText;
  final String lableText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  PasswordTextField({
    required this.hintText,
    required this.isPassword,
    required this.controller,
    this.validator,
    required this.lableText
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppSizes.paddingSm_8,AppSizes.paddingMd_16,AppSizes.paddingSm_8,AppSizes.paddingMd_16),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText:lableText,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
              borderSide: BorderSide(color: Colors.grey,width: AppSizes.textFieldThickness)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface,width: AppSizes.textFieldThickness),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface,width: AppSizes.textFieldThickness),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),

          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width:AppSizes.textFieldThickness),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: AppSizes.textFieldThickness),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          ),
        ),

      ),
    );
  }

}