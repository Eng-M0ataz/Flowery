import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/Config/Theme/app_colors.dart';
import '../../../../../core/Functions/validators.dart';


class BuildPinCode extends StatelessWidget {
  final TextEditingController controller ;
  final void Function(String)? onCompleted;
  const BuildPinCode({super.key, required this.controller,required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller:controller ,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: 80,
        height: 80,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: AppColorsLight.black[10],
          borderRadius: BorderRadius.circular(12),


        ),
      ),
      onCompleted: onCompleted,
      validator: Validations.pinCodeValidator,
      errorPinTheme: PinTheme(
        width: 80,
        height: 80,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
