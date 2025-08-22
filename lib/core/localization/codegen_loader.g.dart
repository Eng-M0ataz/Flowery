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
  "sign_up": "إنشاء حساب",
  "user_name_label": "اسم المستخدم",
  "user_name_hint": "أدخل اسم المستخدم",
  "first_name_label": "الاسم الأول",
  "first_name_hint": "أدخل الاسم الأول",
  "last_name_label": "اسم العائلة",
  "last_name_hint": "أدخل اسم العائلة",
  "email_label": "البريد الإلكتروني",
  "email_hint": "أدخل البريد الإلكتروني",
  "password_label": "كلمة المرور",
  "password_hint": "أدخل كلمة المرور",
  "confirm_password_label": "تأكيد كلمة المرور",
  "confirm_password_hint": "أعد إدخال كلمة المرور",
  "phone_number_label": "رقم الهاتف",
  "phone_number_hint": "أدخل رقم الهاتف",
  "already_have_account_prompt": "هل لديك حساب بالفعل؟",
  "dont_have_account_prompt": "ليس لديك حساب؟",
  "login_link": "تسجيل الدخول",
  "login_button": "تسجيل الدخول",
  "register_button": "تسجيل",
  "forgot_password_link": "نسيت كلمة المرور؟",
  "gender": "الجنس",
  "create_account_prompt": "بإنشائك حساب، فإنك توافق على",
  "terms_and_conditions": "الشروط والأحكام",
  "sign_up_title": "إنشاء حساب",
  "already_have_account": "هل لديك حساب بالفعل؟",
  "login_title": "تسجيل الدخول",
  "account_created_successfully": "تم إنشاء الحساب بنجاح!",
  "success": "نجاح",
  "ok": "موافق",
  "loading": "جاري التحميل...",
  "male": "ذكر",
  "female": "انثى"
};
static const Map<String,dynamic> _en = {
  "sign_up": "Sign up",
  "user_name_label": "Username",
  "user_name_hint": "Enter your user name",
  "first_name_label": "First name",
  "first_name_hint": "Enter first name",
  "last_name_label": "Last name",
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
  "create_account_prompt": "Creating an account, you agree to our",
  "terms_and_conditions": "Terms&Conditions",
  "sign_up_title": "Sign up",
  "already_have_account": "Already have an account?",
  "login_title": "Login",
  "account_created_successfully": "'Account created successfully!'",
  "success": "Success",
  "ok": "OK",
  "loading": "Loading...",
  "male": "Male",
  "female": "Female"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
