// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter_test/flutter_test.dart';
import 'package:emi_books/src/modules/profile/domain/failures/profile_failures.dart';

void main() {
  test('an unknown code falls back to the default message', () {
    expect(
      ProfileUpdateFailure.fromCode('nope').message,
      'An unknown error occurred while updating profile.',
    );
  });

  test('a shared code uses the common message', () {
    expect(
      ProfileUpdateFailure.fromCode('no-current-user').message,
      'No user is currently signed in.',
    );
  });
}
