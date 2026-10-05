// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:emi_books/src/modules/auth/domain/failures/auth_failures.dart';
import 'package:emi_books/src/modules/auth/domain/use_cases/use_cases.dart';
import 'package:emi_books/src/modules/auth/presentation/cubits/sign_in/sign_in_cubit.dart';

class MockSignInUseCase extends Mock
    implements SignInWithEmailAndPasswordUseCase {}

class FakeSignInParam extends Fake implements SignInParam {}

void main() {
  late MockSignInUseCase signIn;

  setUpAll(() => registerFallbackValue(FakeSignInParam()));
  setUp(() => signIn = MockSignInUseCase());

  test('starts idle', () {
    expect(SignInCubit(signIn: signIn).state, const SignInState.idle());
  });

  blocTest<SignInCubit, SignInState>(
    'emits inProgress then success when sign-in succeeds',
    setUp: () => when(
      () => signIn(param: any(named: 'param')),
    ).thenAnswer((_) async => const Right(unit)),
    build: () => SignInCubit(signIn: signIn),
    act: (cubit) => cubit.submit(
      email: 'jane@example.com',
      password: 'Valid#Pass1',
      saveInfo: false,
    ),
    expect: () => [const SignInState.inProgress(), const SignInState.success()],
    verify: (_) {
      final param =
          verify(
                () => signIn(param: captureAny(named: 'param')),
              ).captured.single
              as SignInParam;
      expect(param.email, 'jane@example.com');
      expect(param.saveInfo, isFalse);
    },
  );

  blocTest<SignInCubit, SignInState>(
    'emits inProgress then the failure when sign-in fails',
    setUp: () => when(() => signIn(param: any(named: 'param'))).thenAnswer(
      (_) async => Left(SignInWithEmailAndPasswordFailure.fromCode('x')),
    ),
    build: () => SignInCubit(signIn: signIn),
    act: (cubit) => cubit.submit(
      email: 'jane@example.com',
      password: 'Valid#Pass1',
      saveInfo: false,
    ),
    expect: () => [
      const SignInState.inProgress(),
      SignInState.failure(SignInWithEmailAndPasswordFailure.fromCode('x')),
    ],
  );
}
