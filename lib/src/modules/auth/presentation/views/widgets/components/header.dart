import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';

class Header extends StatelessWidget {
  final String title;
  final String? subtitle;

  const Header({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.tt.headlineMedium?.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: context.cs.secondary,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.tt.titleMedium,
          ),
        ],
      ],
    );
  }
}
