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
  "sign_up": "Sign up",
  "user_name_label": "Username",
  "user_name_hint": "Enter your user name",
  "first_name_label ": "First name",
  "first_name_hint ": "Enter first name",
  "last_name_label ": "Last name",
  "last_name_hint": "Enter last name",
  "email_label": "Email",
  "email_hint": "Enter email",
  "password_label": "Password",
  "password_hint": "Enter password",
  "confirm_password_label": "Confirm password",
  "confirm_password_hint": "Confirm password",
  "phone_number_label": "Phone number",
  "phone_number_hint": "Enter phone number",
  "already_have_account_prompt": "Already have an account?",
  "dont_have_account_prompt": "Don't have an account?",
  "login_link": "Login",
  "login_button": "Login",
  "register_button": "Register",
  "forgot_password_link": "Forgot password?",
  "gender": "Gender",
  "male": "Male",
  "female": "Female",
  "create_account_prompt": "Creating an account, you agree to our",
  " terms_and_conditions": "Terms&Conditions"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
