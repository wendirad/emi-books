// The package import carries the generated project name, which can sort
// differently from here.
// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emi_books/src/core/theme/app_colors.dart';
import 'package:emi_books/src/core/theme/schemes.dart';
import 'package:emi_books/src/modules/auth/presentation/views/widgets/components/auth_footer.dart';

void main() {
  testWidgets('shows the prompt and runs the action when tapped', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: AppColorSchemes.light,
          extensions: const [AppColors.light],
        ),
        home: Scaffold(
          body: AuthFooter(
            prompt: 'Already have an account?',
            actionText: 'Sign In',
            onAction: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Already have an account?'), findsOneWidget);

    await tester.tap(find.text('Sign In'));

    expect(tapped, isTrue);
  });
}
