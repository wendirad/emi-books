import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../domain/validators/validators.dart';
import '../../../extensions/validation_error_message.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final double radius;
  final String? hintText;

  /// When false only checks that a value is present (e.g. sign-in).
  final bool enforceStrength;

  /// When set, this field is a confirmation and must equal this controller's
  /// text.
  final TextEditingController? confirms;

  const PasswordField({
    super.key,
    required this.controller,
    this.radius = 8,
    this.hintText,
    this.enforceStrength = true,
    this.confirms,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  String? _validate(String? value) {
    final ValidationError? error = _check(value);
    return error?.message(context.l10n);
  }

  ValidationError? _check(String? value) {
    final TextEditingController? original = widget.confirms;
    if (original != null) {
      return ConfirmPasswordValidator().call(value, original.text.trim());
    }

    final PasswordValidator validator = PasswordValidator();
    return widget.enforceStrength
        ? validator(value)
        : validator.presence(value);
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      hintText: widget.hintText ?? context.l10n.fieldPassword,
      radius: widget.radius,
      isPasswordField: true,
      obscureText: _obscure,
      onToggleObscure: () => setState(() => _obscure = !_obscure),
      controller: widget.controller,
      validator: _validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
