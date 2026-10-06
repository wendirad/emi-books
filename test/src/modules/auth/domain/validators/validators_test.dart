// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter_test/flutter_test.dart';
import 'package:emi_books/src/modules/auth/domain/validators/validators.dart';

void main() {
  group('EmailValidator', () {
    final validate = EmailValidator().call;

    test('accepts plus tags, dashes and subdomains', () {
      expect(validate('jane+work@mail.example.co.uk'), isNull);
      expect(validate('first_last-name@example.com'), isNull);
    });

    test('rejects missing or malformed addresses', () {
      expect(validate(null), ValidationError.emailInvalid);
      expect(validate(''), ValidationError.emailInvalid);
      expect(validate('no-at-sign.example.com'), ValidationError.emailInvalid);
      expect(validate('user@nodot'), ValidationError.emailInvalid);
    });
  });

  group('CodeValidator', () {
    final validate = CodeValidator().call;

    test('accepts exactly six digits', () {
      expect(validate('123456'), isNull);
      expect(validate(' 123456 '), isNull);
    });

    test('rejects missing, short, long and non numeric codes', () {
      expect(validate(null), ValidationError.codeInvalid);
      expect(validate('12345'), ValidationError.codeInvalid);
      expect(validate('1234567'), ValidationError.codeInvalid);
      expect(validate('12a456'), ValidationError.codeInvalid);
    });
  });

  group('PasswordValidator', () {
    final validator = PasswordValidator();

    test('requires length, case, a digit and a symbol', () {
      expect(validator('Sh0rt!'), ValidationError.passwordTooShort);
      expect(
        validator('alllowercase1!'),
        ValidationError.passwordNeedsUppercase,
      );
      expect(
        validator('ALLUPPERCASE1!'),
        ValidationError.passwordNeedsLowercase,
      );
      expect(validator('NoDigitsHere!'), ValidationError.passwordNeedsNumber);
      expect(validator('NoSymbol123'), ValidationError.passwordNeedsSpecial);
      expect(validator('Valid#Pass1'), isNull);
    });

    test('presence only skips the strength rules', () {
      expect(validator.presence('weak'), isNull);
      expect(validator.presence(''), ValidationError.passwordRequired);
      expect(validator.presence(null), ValidationError.passwordRequired);
    });
  });

  group('ConfirmPasswordValidator', () {
    final validate = ConfirmPasswordValidator().call;

    test('matches only identical passwords', () {
      expect(validate('Valid#Pass1', 'Valid#Pass1'), isNull);
      expect(
        validate('Valid#Pass1', 'Other#Pass1'),
        ValidationError.passwordsDoNotMatch,
      );
      expect(validate('', 'Valid#Pass1'), ValidationError.confirmationRequired);
    });
  });

  group('TextValidator', () {
    final validate = TextValidator().call;

    test('rejects blank values', () {
      expect(validate('  '), ValidationError.valueRequired);
      expect(validate('Jane'), isNull);
    });
  });
}
