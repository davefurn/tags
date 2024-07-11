// ignore_for_file: unrelated_type_equality_checks

import 'package:tags/src/config/utils/agency_constants.dart';

class EmailValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return emptyEmailField;
    }
    // Regex for email validation
    final regExp = RegExp(emailRegex);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return invalidEmailField;
  }
}

class UserNameValidator {
  static String? validateUserName(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }
    if (value.length < 8) {
      return 'Username must be at least 8 characters long';
    }
    final regExp = RegExp(usernameRegex);
    if (regExp.hasMatch(value)) {
      return invalidUsernameField;
    }
    return null;
  }
}

class PhoneNumberValidator {
  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return phoneField;
    }

    final regExp = RegExp(phoneNumberRegex);
    if (!regExp.hasMatch(value)) {
      return invalidPhoneNumberField;
    }

    if (value.length >= 11) {
      return null;
    }
    return invalidPhoneNumberField;
  }
}

class NINValidator {
  static String? validateNIN(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length >= 11) {
      return null;
    }
    return invalidNINField;
  }
}

class OTPValidator {
  static String? validateOTP(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length >= 6) {
      return null;
    }
    return invalidOTPField;
  }
}

class CardValidator {
  static String? validate(String value, int length) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length >= length) {
      return null;
    }
    return 'Invalid number';
  }
}

class DOBValidator {
  static String? validateDOB(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length >= 8) {
      return null;
    }
    return invalidDOBField;
  }
}

class AccountNumberValidator {
  static String? validateAccountNumber(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length == 10) {
      return null;
    }

    return invalidAccountNumberField;
  }
}

class BVNValidator {
  static String? validateBVN(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }
    if (value.length >= 11) {
      return null;
    }
    return invalidBVNField;
  }
}

class FieldValidaor {
  static String? validateField(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }
    if (value.length < 100) {
      return null;
    } else {
      return 'Entry too long';
    }
  }

  static String? validateEmptyfield(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    return null;
  }
}

class AmountValidator {
  static String? validateAmount(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }
    if (num.parse(value.replaceAll(',', '')) <= 0) {
      return 'Amount can not be less than zero';
    }

    return null;
  }
}

class PinValidator {
  static String? validatePin(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length == 4) {
      return null;
    }
    return invalidPinNumberField;
  }
}

class PasswordDigitValidator {
  static String? validateDigitPassword(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length == '') {
      return invalidPasswordNumberField;
    }

    if (value.length == 4) {
      return null;
    }
    // return invalidPasswordNumberField;
    return invalidPinNumberField;
  }
}

class PasswordValidator {
  static String? validatePassword(String value) {
    final regExp = RegExp(passwordRegex);
    if (value.isEmpty) {
      return emptyPasswordField;
    } else if (value.length < 8) {
      return passwordLengthError;
    } else if (!regExp.hasMatch(value)) {
      return invalidPassword;
    } else {
      return null;
    }
  }
}

class ConfirmPasswordValidator {
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password again';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}

class UsernameValidator {
  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return emptyUsernameField;
    }

    if (value.length < 8) {
      return usernameLengthError;
    }

    return null;
  }
}

class FieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }
    return null;
  }
}

class GenderValidator {
  static String? validateGender(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }
    if (value == 'Male' || value == 'MALE' || value == 'male') {
      return null;
    }
    if (value == 'Female' || value == 'FEMALE' || value == 'female') {
      return null;
    }
    return invalidGender;
  }
}
