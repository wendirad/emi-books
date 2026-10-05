// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emi_books/src/core/presentation/widgets/widgets.dart';
import 'package:emi_books/src/core/theme/app_colors.dart';
import 'package:emi_books/src/core/theme/schemes.dart';

Widget host(Widget child) => MaterialApp(
  theme: ThemeData(
    colorScheme: AppColorSchemes.light,
    extensions: const [AppColors.light],
  ),
  home: Scaffold(body: child),
);

void main() {
  testWidgets('calls onPress when tapped', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      host(AppButton(title: 'Save', onPress: () => taps++)),
    );

    await tester.tap(find.text('Save'));

    expect(taps, 1);
  });

  testWidgets('shows a spinner and ignores taps while loading', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      host(AppButton(title: 'Save', isLoading: true, onPress: () => taps++)),
    );

    await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Save'), findsNothing);
    expect(taps, 0);
  });
}
