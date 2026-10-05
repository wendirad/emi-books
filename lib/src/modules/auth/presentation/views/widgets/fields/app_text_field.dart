import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../domain/validators/validators.dart';
import '../../../extensions/validation_error_message.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final double radius;
  final String? hintText;
  final Icon? icon;

  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.icon,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      radius: radius,
      hintText: hintText,
      prefixIcon: icon,
      controller: controller,
      validator: (value) =>
          TextValidator().call(value)?.message(context.l10n),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
