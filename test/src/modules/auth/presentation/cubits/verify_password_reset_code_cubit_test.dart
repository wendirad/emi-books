// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:emi_books/src/modules/auth/domain/failures/auth_failures.dart';
import 'package:emi_books/src/modules/auth/domain/use_cases/use_cases.dart';
import 'package:emi_books/src/modules/auth/presentation/cubits/verify_password_reset_code/verify_password_reset_code_cubit.dart';

class MockVerifyUseCase extends Mock
    implements VerifyPasswordResetCodeUseCase {}

class FakeVerifyParam extends Fake implements VerifyPasswordResetCodeParam {}

void main() {
  late MockVerifyUseCase verifyCode;

  setUpAll(() => registerFallbackValue(FakeVerifyParam()));
  setUp(() => verifyCode = MockVerifyUseCase());

  blocTest<VerifyPasswordResetCodeCubit, VerifyPasswordResetCodeState>(
    'emits inProgress then success for a valid code',
    setUp: () => when(
      () => verifyCode(param: any(named: 'param')),
    ).thenAnswer((_) async => const Right(unit)),
    build: () =>
        VerifyPasswordResetCodeCubit(verifyPasswordResetCode: verifyCode),
    act: (cubit) => cubit.submit(email: 'jane@example.com', code: '123456'),
    expect: () => [
      const VerifyPasswordResetCodeState.inProgress(),
      const VerifyPasswordResetCodeState.success(),
    ],
    verify: (_) {
      final param =
          verifyCall(verifyCode).captured.single
              as VerifyPasswordResetCodeParam;
      expect(param.email, 'jane@example.com');
      expect(param.code, '123456');
    },
  );

  blocTest<VerifyPasswordResetCodeCubit, VerifyPasswordResetCodeState>(
    'emits inProgress then the failure for a wrong or expired code',
    setUp: () => when(() => verifyCode(param: any(named: 'param'))).thenAnswer(
      (_) async =>
          Left(PasswordResetConfirmFailure.fromCode('expired-action-code')),
    ),
    build: () =>
        VerifyPasswordResetCodeCubit(verifyPasswordResetCode: verifyCode),
    act: (cubit) => cubit.submit(email: 'jane@example.com', code: '000000'),
    expect: () => [
      const VerifyPasswordResetCodeState.inProgress(),
      VerifyPasswordResetCodeState.failure(
        PasswordResetConfirmFailure.fromCode('expired-action-code'),
      ),
    ],
  );
}

VerificationResult verifyCall(MockVerifyUseCase useCase) =>
    verify(() => useCase(param: captureAny(named: 'param')));
