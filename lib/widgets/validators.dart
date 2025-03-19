String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Password must contain at least one special character';
  }

  return null; // ✅ Password is valid
}


String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Full Name is required";
  }
  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
    return "Enter a valid name";
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number is required";
  }
  if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
    return "Enter a valid phone number";
  }
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return "Please confirm your password";
  }
  if (value != password) {
    return "Passwords do not match";
  }
  return null;
}
