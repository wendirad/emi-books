// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:emi_books/src/modules/profile/domain/failures/profile_failures.dart';
import 'package:emi_books/src/modules/profile/domain/use_cases/use_cases.dart';
import 'package:emi_books/src/modules/profile/presentation/cubits/update_profile/update_profile_cubit.dart';

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class FakeUpdateProfileParam extends Fake implements UpdateProfileParam {}

void main() {
  late MockUpdateProfileUseCase updateProfile;

  setUpAll(() => registerFallbackValue(FakeUpdateProfileParam()));
  setUp(() => updateProfile = MockUpdateProfileUseCase());

  test('starts idle', () {
    expect(
      UpdateProfileCubit(updateProfile: updateProfile).state,
      const UpdateProfileState.idle(),
    );
  });

  blocTest<UpdateProfileCubit, UpdateProfileState>(
    'emits inProgress then success and passes the fields on',
    setUp: () => when(
      () => updateProfile(param: any(named: 'param')),
    ).thenAnswer((_) async => const Right(unit)),
    build: () => UpdateProfileCubit(updateProfile: updateProfile),
    act: (cubit) => cubit.submit(
      firstName: 'Jane',
      lastName: 'Doe',
      removeProfilePicture: true,
    ),
    expect: () => [
      const UpdateProfileState.inProgress(),
      const UpdateProfileState.success(),
    ],
    verify: (_) {
      final param =
          verify(
                () => updateProfile(param: captureAny(named: 'param')),
              ).captured.single
              as UpdateProfileParam;
      expect(param.firstName, 'Jane');
      expect(param.removeProfilePicture, isTrue);
    },
  );

  blocTest<UpdateProfileCubit, UpdateProfileState>(
    'emits inProgress then the failure when the update fails',
    setUp: () => when(
      () => updateProfile(param: any(named: 'param')),
    ).thenAnswer((_) async => Left(ProfileUpdateFailure.fromCode('x'))),
    build: () => UpdateProfileCubit(updateProfile: updateProfile),
    act: (cubit) => cubit.submit(
      firstName: 'Jane',
      lastName: 'Doe',
      removeProfilePicture: true,
    ),
    expect: () => [
      const UpdateProfileState.inProgress(),
      UpdateProfileState.failure(ProfileUpdateFailure.fromCode('x')),
    ],
  );
}
