abstract class AppRegExp {
  static bool isNameValid(String name) {
    return RegExp(r"^[A-Za-z]{2,}$").hasMatch(name);
  }

  static bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    // Remove all non-digit characters except for the leading +
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    // The regex now optionally matches the country code +20 or 20,
    // followed by an optional 0, then 10/11/12/15, and 8 digits.
    return RegExp(r'^(?:\+20|20)?(?:0)?1[0125][0-9]{8}$').hasMatch(cleaned);
  }

  static bool isOTPValid(String otp) {
    return RegExp(r"^[0-9]{6}$").hasMatch(otp);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
    ).hasMatch(password);
  }
}
