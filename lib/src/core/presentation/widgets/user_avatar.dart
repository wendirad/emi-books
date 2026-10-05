import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/constants.dart';
import '../../extensions/build_context_extensions.dart';

/// Circular user photo with an initials fallback.
///
/// Shows [file] when given (a freshly picked photo), otherwise [photoUrl],
/// otherwise the default avatar from [EndPoints.avatarsPublicProvider].
class UserAvatar extends StatelessWidget {
  final String initials;
  final String? photoUrl;
  final File? file;
  final double size;

  const UserAvatar({
    super.key,
    required this.initials,
    this.photoUrl,
    this.file,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [context.cs.primary, context.cs.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(child: _image(context)),
    );
  }

  Widget _image(BuildContext context) {
    final Widget placeholder = Center(
      child: Text(
        initials,
        style: context.tt.headlineMedium?.copyWith(
          color: context.cs.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final File? localFile = file;
    if (localFile != null) {
      return Image.file(
        localFile,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => placeholder,
      );
    }

    return Image.network(
      photoUrl ?? EndPoints.avatarsPublicProvider,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) => progress == null
          ? child
          : Center(
              child: LoadingAnimationWidget.inkDrop(
                color: context.cs.onPrimary,
                size: size * 0.48,
              ),
            ),
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}
