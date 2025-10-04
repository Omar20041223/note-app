
import 'app_regex.dart';

class Validator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required.';
    }
    if (!AppRegex.isEmailValid(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters long.';
    }
    if (!AppRegex.hasUpperCase(value)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!AppRegex.hasLowerCase(value)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!AppRegex.hasNumber(value)) {
      return 'Password must contain at least one number.';
    }
    if (!AppRegex.hasSpecialCharacter(value)) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }
  static String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty.";
    }
    if (value.length <= 2) {
      return "Username should be at least 3 characters long.";
    }
    if (value.length > 40) {
      return "Username cannot exceed 40 characters.";
    }
    if (!AppRegex.isUsernameValid(value)) {
      return "Please enter a valid username.";
    }
    return null;
  }
}
