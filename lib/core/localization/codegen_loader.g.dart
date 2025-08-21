// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "already_have_account_prompt": "لديك حساب بالفعل ؟",
  "confirm_password_label": "تأكيد كلمة المرور",
  "create_account_button": "إنشاء حساب",
  "create_one_link": "أنشئ واحدًا",
  "dont_have_account_prompt": "ليس لديك حساب ؟",
  "email_label": "البريد الإلكتروني",
  "forgot_password_button": "نسيت كلمة المرور",
  "forgot_password_link": "نسيت كلمة المرور ؟",
  "login_button": "تسجيل الدخول",
  "login_link": "تسجيل الدخول",
  "login_with_google_button": "تسجيل الدخول باستخدام جوجل",
  "name_label": "الاسم",
  "or_separator": "أو",
  "password_label": "كلمة المرور",
  "phone_number_label": "رقم الهاتف",
  "register_button": "تسجيل",
  "reset_password_title": "إعادة تعيين كلمة المرور",
  "sign_up": "انشاء حساب",
  "dog": "كلب"
};
static const Map<String,dynamic> _en = {
  "already_have_account_prompt": "Already Have Account ?",
  "confirm_password_label": "Confirm Password",
  "create_account_button": "Create Account",
  "create_one_link": "Create One",
  "dont_have_account_prompt": "Don't Have Account ?",
  "email_label": "Email",
  "forgot_password_button": "Forget Password",
  "forgot_password_link": "Forget Password ?",
  "login_button": "Login",
  "login_link": "Login",
  "login_with_google_button": "Login With Google",
  "name_label": "Name",
  "or_separator": "OR",
  "password_label": "Password",
  "phone_number_label": "Phone Number",
  "register_button": "Register",
  "reset_password_title": "Reset Password",
  "sign_up": "Sign up",
  "dog": "Dog"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
