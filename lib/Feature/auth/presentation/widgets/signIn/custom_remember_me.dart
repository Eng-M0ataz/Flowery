// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/localization/locale_keys.g.dart';
//
// class CustomRememberMe extends StatelessWidget {
//   const CustomRememberMe({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: context.read<SigninViewModel>().rememberMe,
//           onChanged: (val) {
//             context.read<SigninViewModel>().rememberMe = val ?? false;
//           },
//         ),
//         Text(LocaleKeys.remember_me.tr()),
//       ],
//     );
//   }
// }
