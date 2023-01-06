import 'package:form_field_validator/form_field_validator.dart';

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: '메일이 필요합니다.'),
  EmailValidator(errorText: '유효한 이메일을 입력하세요.')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: '암호가 필요합니다.'),
  MinLengthValidator(8, errorText: '8자 이상 입력해주세요.')
]);
