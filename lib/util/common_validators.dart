import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import 'constant/labels.dart';

class CommonValidators {
  /// Required field validator
  static String? onFieldRequired(value) {
    if (value != null && value.isEmpty) {
      return Labels.validationRequired;
    }
    return null;
  }

  /// Validates an email address.
  ///
  /// Returns `null` if the email is valid, an error message if it's empty or invalid.
  static String? emailValidation(value) {
    // Regular expression for validating email addresses.
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (value.isEmpty) {
      return Labels.validationRequired;
    } else if (!regExp.hasMatch(value)) {
      return Labels.emailRequired;
    }
    return null;
  }

  /// Validates a password.
  static String? changePasswordValidation(value) {
    bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    bool hasNumber = value.contains(RegExp(r'[0-9]'));
    if (value.isEmpty) {
      return Labels.validationRequired;
      // Password is empty or too short.
    } else if (value.length < 8) {
      return Labels.shortPassword;
      // Password too short.
    } else if ((!hasLowerCase || !hasUpperCase || !hasNumber)) {
      return Labels.passwordValidation;
      // Enter a valid password.
    } else {
      return null;
    }
  }

  /// Validates a phone number.
  static String? validatePhoneNumber(String? value, String countryCode) {
    final rawNumber = value?.trim() ?? '';
    final fullNumber = '$countryCode$rawNumber';
    final phoneNumber = PhoneNumber.parse(fullNumber);
    final isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
    if (value == null || value.isEmpty) {
      return Labels.requiredNumber;
    }
    // Check if the value is a valid phone number format
    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return Labels.validNumber;
    }
    if (!isValid) {
      return Labels.selectCode;
    }
    return null; // Return null if the value is valid
  }
}
