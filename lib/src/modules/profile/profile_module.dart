import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      () => ProfileRepository(client: inject<SupabaseClient>()),
    );

    c.addLazySingleton<UpdateProfileUseCase>(
      () =>
          UpdateProfileUseCase(profileRepository: inject<IProfileRepository>()),
    );

    c.route(AppRoute.updateProfile.base, child: (_, _) => UpdateProfileView());
  },
);
