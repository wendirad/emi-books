import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';
import 'auth_banner.dart';
import 'header.dart';
import 'top_bar.dart';

/// Shared layout for the auth screens: top bar, banner and heading above the
/// [form], with the [footer] below it. Scrolls when the keyboard is open.
class AuthScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget form;
  final Widget footer;

  const AuthScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.form,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.surfaceDim,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(28.0).copyWith(top: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TopBar(),

                    Column(
                      spacing: 16,
                      children: [
                        const AuthBanner(),

                        Header(title: title, subtitle: subtitle),
                      ],
                    ),

                    Column(children: [form, footer]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
