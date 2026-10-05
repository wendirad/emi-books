import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../auth/auth.dart';

class ProfileFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  const ProfileFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) =>
          TextValidator().call(value)?.message(context.l10n),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        suffixIcon: Icon(icon, color: context.cs.primary),
        floatingLabelStyle: context.tt.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.cs.tertiary,
        ),
        contentPadding: EdgeInsets.all(18).copyWith(top: 24, bottom: 24),
      ),
    );
  }
}
