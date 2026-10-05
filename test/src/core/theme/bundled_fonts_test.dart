import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// The app turns off runtime font fetching (see main.dart), so every weight it
/// uses must ship in google_fonts/ and be listed under assets in pubspec.yaml.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const files = [
    'Poppins-Regular.ttf', // w400
    'Poppins-Medium.ttf', // w500
    'Poppins-SemiBold.ttf', // w600
    'Poppins-Bold.ttf', // w700
    'Poppins-Black.ttf', // w900
  ];

  for (final file in files) {
    test('bundles $file', () async {
      final data = await rootBundle.load('google_fonts/$file');

      expect(data.lengthInBytes, greaterThan(0));
    });
  }
}
