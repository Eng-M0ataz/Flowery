import 'package:flower_e_commerce_app/core/helpers/regex.dart';

abstract class Validations {
  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return 'Name is required!';
    } else if (!AppRegExp.isNameValid(name)) {
      return 'This Name is not valid';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email is required!';
    } else if (!AppRegExp.isEmailValid(email)) {
      return 'This Email is not valid';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password is required!';
    } else if (!AppRegExp.isPasswordValid(password)) {
      return 'This Password is not valid';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword!.isEmpty) {
      return 'Confirm Password is required!';
    } else if (!AppRegExp.isPasswordValid(confirmPassword)) {
      return 'This Confirm Password is not valid';
    } else if (password != confirmPassword) {
      return 'Password and Confirm Password must be same!';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber!.isEmpty) {
      return 'Phone number is required!';
    } else if (!AppRegExp.isPhoneNumberValid(phoneNumber)) {
      return 'This Phone number is not valid';
    }
    return null;
  }
}
