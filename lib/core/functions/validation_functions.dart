// ignore_for_file: curly_braces_in_flow_control_structures

class AppValidation {
  //? Validation for all field :
  String? validation(String? val) {
    if (val?.isEmpty ?? true)
      return 'This field is required';
    else
      return null;
  }

  //? Validation for email :
  String? emailValidation(String? val) {
    if (val?.isEmpty ?? true)
      return 'This field is required';
    else if (!(val?.contains('@') ?? false))
      return 'Please enter a valid email';
    else
      return null;
  }

  //? Validation for password:
  String? passwordValidation(String? val) {
    if (val?.isEmpty ?? true)
      return 'This field is required';
    else if ((val?.length ?? 0) < 8)
      return 'Password must be more than 7 letters';
    else
      return null;
  }
}
