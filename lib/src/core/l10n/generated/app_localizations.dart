import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
  ];

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @languageSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language of the app'**
  String get settingsLanguageSubtitle;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionTryAgain;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @loadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingTitle;

  /// No description provided for @loadingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Just a moment.'**
  String get loadingSubtitle;

  /// No description provided for @toggleThemeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleThemeTooltip;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open {url}'**
  String couldNotOpenLink(String url);

  /// No description provided for @errorPageNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Lost in Space!'**
  String get errorPageNotFoundTitle;

  /// No description provided for @errorPageNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for seems to be missing. Please go back or visit the homepage.'**
  String get errorPageNotFoundMessage;

  /// No description provided for @errorNoConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'No Connection'**
  String get errorNoConnectionTitle;

  /// No description provided for @errorNoConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re sorry, but you are not connected to the internet. Please check your connection and try again.'**
  String get errorNoConnectionMessage;

  /// No description provided for @errorMaintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Under Maintenance'**
  String get errorMaintenanceTitle;

  /// No description provided for @errorMaintenanceMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re sorry, but the service is currently under maintenance. Please try again later.'**
  String get errorMaintenanceMessage;

  /// No description provided for @errorNoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No Data Found!'**
  String get errorNoDataTitle;

  /// No description provided for @errorNoDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No items were found. Try refreshing, or go back to the home screen.'**
  String get errorNoDataMessage;

  /// No description provided for @errorUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorUnknownTitle;

  /// No description provided for @errorUnknownMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re sorry, but something unexpected happened. Please try again later.'**
  String get errorUnknownMessage;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @splashSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get splashSignIn;

  /// No description provided for @splashCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get splashCreateAccount;

  /// No description provided for @mottoFirstLead.
  ///
  /// In en, this message translates to:
  /// **'Always '**
  String get mottoFirstLead;

  /// No description provided for @mottoFirstEmphasis.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get mottoFirstEmphasis;

  /// No description provided for @mottoSecondLead.
  ///
  /// In en, this message translates to:
  /// **'Always '**
  String get mottoSecondLead;

  /// No description provided for @mottoSecondEmphasis.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get mottoSecondEmphasis;

  /// No description provided for @mottoSentenceEnd.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get mottoSentenceEnd;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get settingsErrorTitle;

  /// No description provided for @settingsEditProfileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsEditProfileTooltip;

  /// No description provided for @settingsNoEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get settingsNoEmail;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeTitle;

  /// No description provided for @settingsThemeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark mode'**
  String get settingsThemeSubtitle;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy policy'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settingsTermsTitle;

  /// No description provided for @settingsTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our terms of service'**
  String get settingsTermsSubtitle;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutTitle;

  /// No description provided for @settingsAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App version and information'**
  String get settingsAboutSubtitle;

  /// No description provided for @aboutFollowUs.
  ///
  /// In en, this message translates to:
  /// **'Follow Us'**
  String get aboutFollowUs;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignIn;

  /// No description provided for @authSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUp;

  /// No description provided for @authSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get authSignOut;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @fieldConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get fieldConfirmPassword;

  /// No description provided for @fieldBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get fieldBusinessName;

  /// No description provided for @signInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sign In successful'**
  String get signInSuccess;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In into your account'**
  String get signInSubtitle;

  /// No description provided for @signInNoAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get signInNoAccountPrompt;

  /// No description provided for @signInFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In Failed'**
  String get signInFailedTitle;

  /// No description provided for @signInRememberEmail.
  ///
  /// In en, this message translates to:
  /// **'Remember my email'**
  String get signInRememberEmail;

  /// No description provided for @signInForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get signInForgotPassword;

  /// No description provided for @signOutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logout successful'**
  String get signOutSuccess;

  /// No description provided for @signOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get signOutSubtitle;

  /// No description provided for @signOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out of your account?'**
  String get signOutConfirmMessage;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Email Sent Successfully!'**
  String get passwordResetEmailSent;

  /// No description provided for @passwordResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get passwordResetTitle;

  /// No description provided for @passwordResetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password with email'**
  String get passwordResetSubtitle;

  /// No description provided for @passwordResetRememberPrompt.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get passwordResetRememberPrompt;

  /// No description provided for @passwordResetFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Failed'**
  String get passwordResetFailedTitle;

  /// No description provided for @passwordResetConfirmationFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Confirmation Failed'**
  String get passwordResetConfirmationFailedTitle;

  /// No description provided for @passwordResetSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Password Reset Email'**
  String get passwordResetSendButton;

  /// No description provided for @confirmResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Successfully!'**
  String get confirmResetSuccess;

  /// No description provided for @confirmResetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set your new password'**
  String get confirmResetSubtitle;

  /// No description provided for @confirmResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get confirmResetButton;

  /// No description provided for @signUpSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sign up successful'**
  String get signUpSuccess;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your new account'**
  String get signUpSubtitle;

  /// No description provided for @signUpHasAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signUpHasAccountPrompt;

  /// No description provided for @signUpFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Failed'**
  String get signUpFailedTitle;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validationPasswordTooShort;

  /// No description provided for @validationPasswordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Include at least one uppercase letter'**
  String get validationPasswordUppercase;

  /// No description provided for @validationPasswordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Include at least one lowercase letter'**
  String get validationPasswordLowercase;

  /// No description provided for @validationPasswordNumber.
  ///
  /// In en, this message translates to:
  /// **'Include at least one number'**
  String get validationPasswordNumber;

  /// No description provided for @validationPasswordSpecial.
  ///
  /// In en, this message translates to:
  /// **'Include at least one special character'**
  String get validationPasswordSpecial;

  /// No description provided for @validationConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validationConfirmRequired;

  /// No description provided for @validationPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsMismatch;

  /// No description provided for @validationValueRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid value.'**
  String get validationValueRequired;

  /// No description provided for @failureUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown exception occurred.'**
  String get failureUnknown;

  /// No description provided for @failureNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection.'**
  String get failureNetwork;

  /// No description provided for @failureInternal.
  ///
  /// In en, this message translates to:
  /// **'An internal error occurred. Please try again later.'**
  String get failureInternal;

  /// No description provided for @failureUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user has been disabled. Please contact support for help.'**
  String get failureUserDisabled;

  /// No description provided for @failureOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Operation is not allowed. Please contact support.'**
  String get failureOperationNotAllowed;

  /// No description provided for @failureTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later.'**
  String get failureTooManyRequests;

  /// No description provided for @failureNoCurrentUser.
  ///
  /// In en, this message translates to:
  /// **'No user is currently signed in.'**
  String get failureNoCurrentUser;

  /// No description provided for @failureRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'This operation requires recent authentication. Please sign in again.'**
  String get failureRequiresRecentLogin;

  /// No description provided for @failureSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get failureSessionExpired;

  /// No description provided for @failureInvalidSessionCookie.
  ///
  /// In en, this message translates to:
  /// **'The session cookie is invalid.'**
  String get failureInvalidSessionCookie;

  /// No description provided for @failureTokenRevoked.
  ///
  /// In en, this message translates to:
  /// **'The session has been revoked. Please sign in again.'**
  String get failureTokenRevoked;

  /// No description provided for @failureInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Email is not valid or badly formatted.'**
  String get failureInvalidEmail;

  /// No description provided for @failureEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already exists for that email.'**
  String get failureEmailInUse;

  /// No description provided for @failureWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a stronger password.'**
  String get failureWeakPassword;

  /// No description provided for @failureInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The supplied credential is invalid or has expired.'**
  String get failureInvalidCredential;

  /// No description provided for @failureAccountExistsDifferent.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with a different sign-in method.'**
  String get failureAccountExistsDifferent;

  /// No description provided for @failureCredentialInUse.
  ///
  /// In en, this message translates to:
  /// **'This credential is already associated with a different user account.'**
  String get failureCredentialInUse;

  /// No description provided for @failureSignInFallback.
  ///
  /// In en, this message translates to:
  /// **'Please make sure your email and password are correct.'**
  String get failureSignInFallback;

  /// No description provided for @failureActionCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'The action code has expired.'**
  String get failureActionCodeExpired;

  /// No description provided for @failureActionCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The action code is invalid or has already been used.'**
  String get failureActionCodeInvalid;

  /// No description provided for @failureActionUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user corresponding to the action code was found.'**
  String get failureActionUserNotFound;

  /// No description provided for @failureNewPasswordWeak.
  ///
  /// In en, this message translates to:
  /// **'The new password is not strong enough.'**
  String get failureNewPasswordWeak;

  /// No description provided for @failureSignOutFallback.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred while signing out.'**
  String get failureSignOutFallback;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileUserNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'User Data Not Found'**
  String get profileUserNotFoundTitle;

  /// No description provided for @profileUserNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to load user data. Please try again later or contact support.'**
  String get profileUserNotFoundMessage;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile Update Successful!'**
  String get profileUpdateSuccess;

  /// No description provided for @profileUpdateFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Update Failure'**
  String get profileUpdateFailedTitle;

  /// No description provided for @profileFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get profileFirstName;

  /// No description provided for @profileLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get profileLastName;

  /// No description provided for @profileUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get profileUpdateButton;

  /// No description provided for @profilePickImageError.
  ///
  /// In en, this message translates to:
  /// **'Error picking image'**
  String get profilePickImageError;

  /// No description provided for @profilePhotoGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get profilePhotoGallery;

  /// No description provided for @profilePhotoCamera.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get profilePhotoCamera;

  /// No description provided for @profilePhotoRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get profilePhotoRemove;

  /// No description provided for @failureProfileFallback.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred while updating profile.'**
  String get failureProfileFallback;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
