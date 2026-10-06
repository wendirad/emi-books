// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:emi_books/src/modules/auth/domain/failures/auth_failures.dart';
import 'package:emi_books/src/modules/auth/domain/use_cases/use_cases.dart';
import 'package:emi_books/src/modules/auth/presentation/cubits/confirm_password_reset/confirm_password_reset_cubit.dart';

class MockConfirmUseCase extends Mock implements ConfirmPasswordResetUseCase {}

class FakeConfirmParam extends Fake implements ConfirmPasswordResetParam {}

void main() {
  late MockConfirmUseCase confirm;

  setUpAll(() => registerFallbackValue(FakeConfirmParam()));
  setUp(() => confirm = MockConfirmUseCase());

  blocTest<ConfirmPasswordResetCubit, ConfirmPasswordResetState>(
    'emits inProgress then success and passes the new password',
    setUp: () => when(
      () => confirm(param: any(named: 'param')),
    ).thenAnswer((_) async => const Right(unit)),
    build: () => ConfirmPasswordResetCubit(confirmPasswordReset: confirm),
    act: (cubit) => cubit.submit(newPassword: 'Valid#Pass1'),
    expect: () => [
      const ConfirmPasswordResetState.inProgress(),
      const ConfirmPasswordResetState.success(),
    ],
    verify: (_) {
      final param =
          verify(
                () => confirm(param: captureAny(named: 'param')),
              ).captured.single
              as ConfirmPasswordResetParam;
      expect(param.newPassword, 'Valid#Pass1');
    },
  );

  blocTest<ConfirmPasswordResetCubit, ConfirmPasswordResetState>(
    'emits inProgress then the failure when the password is rejected',
    setUp: () => when(() => confirm(param: any(named: 'param'))).thenAnswer(
      (_) async => Left(PasswordResetConfirmFailure.fromCode('weak-password')),
    ),
    build: () => ConfirmPasswordResetCubit(confirmPasswordReset: confirm),
    act: (cubit) => cubit.submit(newPassword: 'weak'),
    expect: () => [
      const ConfirmPasswordResetState.inProgress(),
      ConfirmPasswordResetState.failure(
        PasswordResetConfirmFailure.fromCode('weak-password'),
      ),
    ],
  );
}
