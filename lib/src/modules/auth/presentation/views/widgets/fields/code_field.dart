import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../domain/validators/code_validator.dart';
import '../../../extensions/validation_error_message.dart';

class CodeField extends StatelessWidget {
  final TextEditingController controller;
  final double radius;

  const CodeField({super.key, required this.controller, this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return InputField(
      radius: radius,
      hintText: context.l10n.fieldCode,
      prefixIcon: Icon(Icons.pin, color: context.cs.secondary),
      controller: controller,
      keyboardType: TextInputType.number,
      autofillHints: const [AutofillHints.oneTimeCode],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      validator: (value) => CodeValidator().call(value)?.message(context.l10n),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
