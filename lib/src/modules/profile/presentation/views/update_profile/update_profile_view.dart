import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/presentation/errors/errors.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../auth/auth.dart';
import '../../../domain/use_cases/update_profile_use_case.dart';
import '../../cubits/update_profile/update_profile_cubit.dart';
import '../../extensions/profile_failure_message.dart';
import '../widgets/profile_form_field.dart';
import 'widgets/photo_update_widget.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final GlobalKey<FormState> _profileUpdateFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          context.l10n.profileEditTitle,
          style: context.tt.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: _ProfileUpdateForm(formKey: _profileUpdateFormKey),
        ),
      ),
    );
  }
}

class _ProfileUpdateForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const _ProfileUpdateForm({required this.formKey});

  @override
  State<_ProfileUpdateForm> createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<_ProfileUpdateForm> {
  File? _profilePicture;
  bool _removeProfilePicture = false;
  bool _prefilled = false;

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_prefilled) return;
    _prefilled = true;
    _loadPrefilledData();
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.routeState().arguments;

    if (user == null || user is! AuthUser) {
      return ErrorView(
        errorType: ErrorTypes.noData,
        title: context.l10n.profileUserNotFoundTitle,
        description: context.l10n.profileUserNotFoundMessage,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PhotoUpdateWidget(
          initials: user.initials,
          photoUrl: user.photoUrl,
          onPhotoSelected: (selectedPhoto) => setState(() {
            _profilePicture = selectedPhoto;
            _removeProfilePicture = false;
          }),
          onPhotoRemoved: () => setState(() {
            _profilePicture = null;
            _removeProfilePicture = true;
          }),
        ),

        if (user is BusinessUser) ...[
          Text(
            user.businessName,
            style: context.tt.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.cs.inversePrimary.withAlpha(200),
            ),
          ),
        ],

        SizedBox(height: 16),

        Text(
          user.email!,
          style: context.tt.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: context.cs.inversePrimary.withAlpha(150),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateProfileCubit(
            updateProfile: inject<UpdateProfileUseCase>(),
          ),
          child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listenWhen: (p, c) => p != c,
            listener: (context, state) async {
              if (state.isSuccess) {
                AppSnackBar.success(context, context.l10n.profileUpdateSuccess);
                await context.popAndPushNamed(AppRoute.settings.str);
              }
            },
            builder: (context, state) {
              return Form(
                key: widget.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(top: 64),
                  child: Column(
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.failure case final failure?) ...[
                        AppAlert(
                          title: context.l10n.profileUpdateFailedTitle,
                          value: failure.localized(context.l10n),
                          variant: AlertVariant.danger,
                          icon: Icons.report_gmailerrorred_outlined,
                        ),
                      ],
                      if (user is BusinessUser) ...[
                        ProfileFormField(
                          controller: _businessNameController,
                          labelText: context.l10n.fieldBusinessName,
                          icon: Icons.business_center,
                        ),
                      ],
                      ProfileFormField(
                        controller: _firstNameController,
                        labelText: context.l10n.profileFirstName,
                        icon: Icons.text_fields,
                      ),

                      ProfileFormField(
                        controller: _lastNameController,
                        labelText: context.l10n.profileLastName,
                        icon: Icons.text_fields,
                      ),

                      AppButton(
                        onPress: () {
                          if (!widget.formKey.currentState!.validate()) return;

                          ReadContext(
                            context,
                          ).read<UpdateProfileCubit>().submit(
                            businessName: user is BusinessUser
                                ? _businessNameController.text.trim()
                                : null,
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            profilePicture: _profilePicture,
                            removeProfilePicture: _removeProfilePicture,
                          );
                        },
                        isLoading: state.isInProgress,
                        title: context.l10n.profileUpdateButton,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _loadPrefilledData() {
    final user = context.routeState(listen: false).arguments;
    if (user is! AuthUser) return;

    if (user is BusinessUser) {
      _businessNameController.text = user.businessName;
    }
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
  }
}
