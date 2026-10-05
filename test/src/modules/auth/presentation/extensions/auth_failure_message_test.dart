// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter_test/flutter_test.dart';
import 'package:emi_books/src/core/l10n/generated/app_localizations_am.dart';
import 'package:emi_books/src/core/l10n/generated/app_localizations_en.dart';
import 'package:emi_books/src/modules/auth/domain/failures/auth_failures.dart';
import 'package:emi_books/src/modules/auth/domain/validators/validation_error.dart';
import 'package:emi_books/src/modules/auth/presentation/extensions/auth_failure_message.dart';
import 'package:emi_books/src/modules/auth/presentation/extensions/validation_error_message.dart';

void main() {
  final en = AppLocalizationsEn();
  final am = AppLocalizationsAm();

  test('the English text matches the failure message', () {
    for (final code in [
      'invalid-email',
      'email-already-in-use',
      'weak-password',
    ]) {
      final failure = SignUpWithEmailAndPasswordFailure.fromCode(code);
      expect(failure.localized(en), failure.message, reason: code);
    }
    final shared = SignInWithEmailAndPasswordFailure.fromCode(
      'too-many-requests',
    );
    expect(shared.localized(en), shared.message);
  });

  test('an unknown code falls back to the failure\'s own default', () {
    final failure = SignInWithEmailAndPasswordFailure.fromCode('nope');
    expect(failure.localized(en), failure.message);
    expect(failure.localized(am), isNot(failure.localized(en)));
  });

  test('Amharic is used when the language is Amharic', () {
    final failure = PasswordResetConfirmFailure.fromCode('expired-action-code');
    expect(failure.localized(am), am.failureActionCodeExpired);
    expect(failure.localized(am), isNot(failure.localized(en)));
  });

  test('every validation error has text in both languages', () {
    for (final error in ValidationError.values) {
      expect(error.message(en), isNotEmpty, reason: '$error');
      expect(error.message(am), isNot(error.message(en)), reason: '$error');
    }
  });
}
