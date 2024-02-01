String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required.';
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required.';
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email address.';
  }

  return null;
}

String? validatePassword(String? value, {bool strong = true}) {
  if (value == null || value.isEmpty) {
    return 'Password is required.';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters.';
  }

  if (strong) {
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
  }

  return null;
}

String? validateConfirmPassword(String? value, String? confirmValue) {
  if (value == null || value.isEmpty) {
    return 'Confirm password is required.';
  }

  if (value != confirmValue) {
    return 'Passwords do not match.';
  }

  return null;
}
