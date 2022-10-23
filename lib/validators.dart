import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required'),
  MinLengthValidator(2, errorText: 'Too short'),
  MaxLengthValidator(25, errorText: 'Too long')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: 'Please enter a valid email')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(6, errorText: 'Too short'),
  MaxLengthValidator(30,
      errorText: 'Too long'),
  PatternValidator(r'(?=.*?[#?+.,<>?!@$%,^&*-])',
      errorText: 'Passwords must have at least one special character'),

]);

final matchPasswordValidator = MultiValidator([
  RequiredValidator(errorText: 'Enter your password again'),
]);


final addressValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required'),
  MinLengthValidator(2, errorText: 'Address is too short'),
  MaxLengthValidator(500, errorText: 'Address cannot be more than 500 characters')
]);
