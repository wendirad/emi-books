import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';
import 'src/app/app_module.dart';
import 'src/app/app_widget.dart';
import 'src/core/constants/constants.dart';
import 'src/core/l10n/l10n.dart';
import 'src/core/theme/theme.dart';
import 'src/core/utils/utils.dart';

Future<void> setupFirebase() async {
  final EnvLoader env = EnvLoader.instance;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? AndroidDebugProvider(
            debugToken: env.getOptionalString(EnvKeys.androidDebugToken),
          )
        : AndroidPlayIntegrityProvider(),
    providerApple: kDebugMode
        ? AppleDebugProvider(
            debugToken: env.getOptionalString(EnvKeys.appleDebugToken),
          )
        : AppleAppAttestProvider(),
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );

  await FirebaseAuth.instance.setLanguageCode('en');

  if (kDebugMode) {
    await FirebaseAuth.instance.setSettings(
      appVerificationDisabledForTesting: true,
    );
  }

  if (kDebugMode && env.getBool(EnvKeys.useEmulators)) {
    final String host = env.getString(EnvKeys.emulatorDebugHost);

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      env.getInt(EnvKeys.authEmulatorPort),
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      env.getInt(EnvKeys.firestoreEmulatorPort),
    );

    await FirebaseStorage.instance.useStorageEmulator(
      host,
      env.getInt(EnvKeys.storageEmulatorPort),
    );

    final String? debugToken = await FirebaseAppCheck.instance.getToken();
    debugPrint('Debug Token: ${debugToken?.isNotEmpty}');
  }
}

Future<void> setupSupabase() async {
  final EnvLoader env = EnvLoader.instance;

  await Supabase.initialize(
    url: env.getString(EnvKeys.supabaseUrl),
    publishableKey: env.getString(EnvKeys.supabaseAnonKey),
    httpClient: AppCheckHttpClient(),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fonts ship in google_fonts/ so text renders the same offline.
  GoogleFonts.config.allowRuntimeFetching = false;

  await EnvLoader.instance.load();

  await setupFirebase();
  await setupSupabase();

  final ThemeService themeService = ThemeService();
  await themeService.load();

  final LocaleService localeService = LocaleService();
  await localeService.load();

  runApp(
    ModularApp(
      initialRoute: AppRoute.home.str,
      module: appModule(
        themeService: themeService,
        localeService: localeService,
      ),
      child: AppWidget(),
    ),
  );
}
