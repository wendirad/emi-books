// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:emi_books/src/modules/auth/domain/failures/auth_failures.dart';
import 'package:emi_books/src/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:emi_books/src/modules/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late SignInWithEmailAndPasswordUseCase useCase;

  const param = SignInParam(
    email: 'jane@example.com',
    password: 'Valid#Pass1',
    saveInfo: true,
  );

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignInWithEmailAndPasswordUseCase(authRepository: repository);
  });

  test('passes the param to the repository and returns its result', () async {
    when(
      () => repository.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
        saveInfo: any(named: 'saveInfo'),
      ),
    ).thenAnswer((_) async => const Right(unit));

    final result = await useCase(param: param);

    expect(result, const Right<SignInWithEmailAndPasswordFailure, Unit>(unit));
    verify(
      () => repository.signInWithEmailAndPassword(
        email: 'jane@example.com',
        password: 'Valid#Pass1',
        saveInfo: true,
      ),
    ).called(1);
  });

  test('returns the failure unchanged', () async {
    final failure = SignInWithEmailAndPasswordFailure.fromCode('user-disabled');
    when(
      () => repository.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
        saveInfo: any(named: 'saveInfo'),
      ),
    ).thenAnswer((_) async => Left(failure));

    expect(
      await useCase(param: param),
      Left<SignInWithEmailAndPasswordFailure, Unit>(failure),
    );
  });
}
