import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/constants.dart';
import 'data/repositories/profile_repository.dart';
import 'domain/repositories/i_profile_repository.dart';
import 'domain/use_cases/use_cases.dart';
import 'presentation/views/views.dart';

/// Profile dependencies and routes. Mount with
/// `c.module(profileModule, at: AppRoute.profile.base)`; the binds live while a
/// profile route is open.
final Module profileModule = createModule(
  register: (c) {
    c.addLazySingleton<IProfileRepository>(
      () => ProfileRepository(
        auth: inject<FirebaseAuth>(),
        store: inject<FirebaseFirestore>(),
        storage: inject<FirebaseStorage>(),
      ),
    );

    c.addLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(
        profileRepository: inject<IProfileRepository>(),
      ),
    );

    c.route(AppRoute.updateProfile.base, child: (_, _) => UpdateProfileView());
  },
);
