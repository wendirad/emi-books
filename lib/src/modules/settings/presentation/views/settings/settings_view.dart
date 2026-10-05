import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/presentation/errors/errors.dart';
import '../../../../../core/presentation/launch_link.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../auth/auth.dart';
import '../widgets/app_version_text.dart';
import '../widgets/language_sheet.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CurrentUserCubit(getCurrentUser: inject<GetCurrentUserUseCase>())
            ..load(),
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          if (state.data case final user?) {
            return _SettingsContent(user: user);
          }

          if (state.failure case final failure?) {
            return ErrorView(
              title: context.l10n.settingsErrorTitle,
              description: failure.message,
              onButtonPress: () async =>
                  ReadContext(context).read<CurrentUserCubit>().load(),
            );
          }

          return AsyncPageLoader.loading();
        },
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  final AuthUser user;

  const _SettingsContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cs.surface,
      appBar: AppBar(
        title: Text(
          context.l10n.settingsTitle,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              _ProfileSettings(user: user),
              const SizedBox(height: 24),

              // General Settings
              _GeneralSettings(),
              const SizedBox(height: 24),

              // Account
              _AccountSettings(),
              const SizedBox(height: 24),

              // Sign Out
              BlocProvider(
                create: (context) =>
                    SignOutCubit(signOut: inject<SignOutUseCase>()),
                child: const SignOutCard(),
              ),
              const SizedBox(height: 32),

              // App Version
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: AppVersionText(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSettings extends StatelessWidget {
  final AuthUser user;

  const _ProfileSettings({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              top: -15,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () async => await context.pushNamed(
                  AppRoute.updateProfile.str,
                  arguments: user,
                ),
                tooltip: context.l10n.settingsEditProfileTooltip,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              ),
            ),
            Row(
              children: [
                UserAvatar(initials: user.initials, photoUrl: user.photoUrl),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: context.tt.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email ?? context.l10n.settingsNoEmail,
                        style: context.tt.bodyMedium?.copyWith(
                          color: context.cs.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GeneralSettings extends StatelessWidget {
  const _GeneralSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            context.l10n.settingsGeneral,
            style: context.tt.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.cs.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.palette_outlined,
                title: context.l10n.settingsThemeTitle,
                subtitle: context.l10n.settingsThemeSubtitle,
                trailing: _ThemeToggle(),
              ),
              const Divider(height: 1),
              ListenableBuilder(
                listenable: inject<LocaleService>(),
                builder: (context, _) => _SettingsTile(
                  icon: Icons.language,
                  title: context.l10n.settingsLanguageTitle,
                  subtitle: currentLanguageLabel(
                    context,
                    inject<LocaleService>().locale,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showLanguageSheet(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final themeService = inject<ThemeService>();

    return Switch(
      value: isDark,
      onChanged: (_) => themeService.toggle(context.brightness),
    );
  }
}

class _AccountSettings extends StatelessWidget {
  const _AccountSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            context.l10n.settingsAccount,
            style: context.tt.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.cs.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              if (AppLinks.privacyPolicy.isNotEmpty) ...[
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: context.l10n.settingsPrivacyTitle,
                  subtitle: context.l10n.settingsPrivacySubtitle,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => launchLink(context, AppLinks.privacyPolicy),
                ),
                const Divider(height: 1),
              ],
              if (AppLinks.termsOfService.isNotEmpty) ...[
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: context.l10n.settingsTermsTitle,
                  subtitle: context.l10n.settingsTermsSubtitle,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => launchLink(context, AppLinks.termsOfService),
                ),
                const Divider(height: 1),
              ],
              _SettingsTile(
                icon: Icons.info_outline,
                title: context.l10n.settingsAboutTitle,
                subtitle: context.l10n.settingsAboutSubtitle,
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await context.pushNamed(AppRoute.about.str);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = context.cs.primary;
    final titleColor = context.cs.onSurface;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.cs.primaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: context.tt.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: titleColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.tt.bodySmall?.copyWith(
                color: context.cs.onSurface.withValues(alpha: 0.6),
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
