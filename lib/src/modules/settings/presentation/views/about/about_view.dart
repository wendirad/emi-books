import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/launch_link.dart';
import '../widgets/app_version_text.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.surface,
      appBar: AppBar(
        title: Text(
          context.l10n.settingsAboutTitle,
          style: context.tt.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 32,
            children: [
              // App Logo/Icon
              _AppIcon(),

              // App Name and Version
              _AppInfo(),

              // App Description
              _AppDescription(),

              // Version Info
              _VersionInfo(),

              // Social Media Links
              _SocialMedia(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [context.cs.primary, context.cs.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: context.cs.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(Illustrations.splashScreenMain),
    );
  }
}

class _AppInfo extends StatelessWidget {
  const _AppInfo();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Emi Books',
      style: context.tt.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.cs.onSurface,
      ),
    );
  }
}

class _AppDescription extends StatelessWidget {
  const _AppDescription();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              r'''AI-powered study companion for Ethiopian high school students.''',
              style: context.tt.bodyMedium?.copyWith(
                color: context.cs.onSurface.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionInfo extends StatelessWidget {
  const _VersionInfo();

  @override
  Widget build(BuildContext context) {
    final int year = DateTime.now().year;
    return Column(
      children: [
        const AppVersionText(),
        const SizedBox(height: 8),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.copyright_outlined), Text('$year')],
        ),
      ],
    );
  }
}

class _SocialMedia extends StatelessWidget {
  const _SocialMedia();

  @override
  Widget build(BuildContext context) {
    final Map<ButtonType, String> links = {
      ButtonType.facebook: AppLinks.facebook,
      ButtonType.twitter: AppLinks.twitter,
      ButtonType.linkedin: AppLinks.linkedin,
    }..removeWhere((_, url) => url.isEmpty);

    if (links.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          context.l10n.aboutFollowUs,
          style: context.tt.titleSmall?.copyWith(
            color: context.cs.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final MapEntry(key: type, value: url) in links.entries)
              Transform.scale(
                scale: 0.7,
                child: FlutterSocialButton(
                  onTap: () => launchLink(context, url),
                  mini: true,
                  buttonType: type,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
