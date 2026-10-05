// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose the language of the app';

  @override
  String get actionBack => 'Back';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionTryAgain => 'Try again';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get loadingTitle => 'Loading';

  @override
  String get loadingSubtitle => 'Just a moment.';

  @override
  String get toggleThemeTooltip => 'Toggle theme';

  @override
  String couldNotOpenLink(String url) {
    return 'Could not open $url';
  }

  @override
  String get errorPageNotFoundTitle => 'Lost in Space!';

  @override
  String get errorPageNotFoundMessage =>
      'The page you are looking for seems to be missing. Please go back or visit the homepage.';

  @override
  String get errorNoConnectionTitle => 'No Connection';

  @override
  String get errorNoConnectionMessage =>
      'We\'re sorry, but you are not connected to the internet. Please check your connection and try again.';

  @override
  String get errorMaintenanceTitle => 'Under Maintenance';

  @override
  String get errorMaintenanceMessage =>
      'We\'re sorry, but the service is currently under maintenance. Please try again later.';

  @override
  String get errorNoDataTitle => 'No Data Found!';

  @override
  String get errorNoDataMessage =>
      'No items were found. Try refreshing, or go back to the home screen.';

  @override
  String get errorUnknownTitle => 'Something went wrong';

  @override
  String get errorUnknownMessage =>
      'We\'re sorry, but something unexpected happened. Please try again later.';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'Settings';

  @override
  String get splashSignIn => 'Sign In';

  @override
  String get splashCreateAccount => 'Create an account';

  @override
  String get mottoFirstLead => 'Always ';

  @override
  String get mottoFirstEmphasis => 'On';

  @override
  String get mottoSecondLead => 'Always ';

  @override
  String get mottoSecondEmphasis => 'Professional';

  @override
  String get mottoSentenceEnd => '.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsErrorTitle => 'Oops!';

  @override
  String get settingsEditProfileTooltip => 'Edit Profile';

  @override
  String get settingsNoEmail => 'No email';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsThemeTitle => 'Theme';

  @override
  String get settingsThemeSubtitle => 'Switch between light and dark mode';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsPrivacyTitle => 'Privacy Policy';

  @override
  String get settingsPrivacySubtitle => 'Read our privacy policy';

  @override
  String get settingsTermsTitle => 'Terms of Service';

  @override
  String get settingsTermsSubtitle => 'Read our terms of service';

  @override
  String get settingsAboutTitle => 'About';

  @override
  String get settingsAboutSubtitle => 'App version and information';

  @override
  String get aboutFollowUs => 'Follow Us';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authSignOut => 'Sign Out';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldConfirmPassword => 'Confirm Password';

  @override
  String get fieldBusinessName => 'Business Name';

  @override
  String get signInSuccess => 'Sign In successful';

  @override
  String get signInTitle => 'Welcome Back';

  @override
  String get signInSubtitle => 'Sign In into your account';

  @override
  String get signInNoAccountPrompt => 'Don\'t have account?';

  @override
  String get signInFailedTitle => 'Sign In Failed';

  @override
  String get signInRememberEmail => 'Remember my email';

  @override
  String get signInForgotPassword => 'Forgot Password?';

  @override
  String get signOutSuccess => 'Logout successful';

  @override
  String get signOutSubtitle => 'Sign out of your account';

  @override
  String get signOutConfirmMessage =>
      'Are you sure you want to sign out of your account?';

  @override
  String get passwordResetEmailSent =>
      'Password Reset Email Sent Successfully!';

  @override
  String get passwordResetTitle => 'Forgot Your Password?';

  @override
  String get passwordResetSubtitle => 'Reset your password with email';

  @override
  String get passwordResetRememberPrompt => 'Remember your password?';

  @override
  String get passwordResetFailedTitle => 'Password Reset Failed';

  @override
  String get passwordResetConfirmationFailedTitle =>
      'Password Reset Confirmation Failed';

  @override
  String get passwordResetSendButton => 'Send Password Reset Email';

  @override
  String get confirmResetSuccess => 'Password Reset Successfully!';

  @override
  String get confirmResetSubtitle => 'Set your new password';

  @override
  String get confirmResetButton => 'Reset Password';

  @override
  String get signUpSuccess => 'Sign up successful';

  @override
  String get signUpTitle => 'Register';

  @override
  String get signUpSubtitle => 'Create your new account';

  @override
  String get signUpHasAccountPrompt => 'Already have an account?';

  @override
  String get signUpFailedTitle => 'Sign Up Failed';

  @override
  String get validationEmailInvalid => 'Enter a valid email.';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get validationPasswordUppercase =>
      'Include at least one uppercase letter';

  @override
  String get validationPasswordLowercase =>
      'Include at least one lowercase letter';

  @override
  String get validationPasswordNumber => 'Include at least one number';

  @override
  String get validationPasswordSpecial =>
      'Include at least one special character';

  @override
  String get validationConfirmRequired => 'Please confirm your password';

  @override
  String get validationPasswordsMismatch => 'Passwords do not match';

  @override
  String get validationValueRequired => 'Enter a valid value.';

  @override
  String get failureUnknown => 'An unknown exception occurred.';

  @override
  String get failureNetwork =>
      'Network error. Please check your internet connection.';

  @override
  String get failureInternal =>
      'An internal error occurred. Please try again later.';

  @override
  String get failureUserDisabled =>
      'This user has been disabled. Please contact support for help.';

  @override
  String get failureOperationNotAllowed =>
      'Operation is not allowed. Please contact support.';

  @override
  String get failureTooManyRequests =>
      'Too many requests. Please try again later.';

  @override
  String get failureNoCurrentUser => 'No user is currently signed in.';

  @override
  String get failureRequiresRecentLogin =>
      'This operation requires recent authentication. Please sign in again.';

  @override
  String get failureSessionExpired =>
      'Your session has expired. Please sign in again.';

  @override
  String get failureInvalidSessionCookie => 'The session cookie is invalid.';

  @override
  String get failureTokenRevoked =>
      'The session has been revoked. Please sign in again.';

  @override
  String get failureInvalidEmail => 'Email is not valid or badly formatted.';

  @override
  String get failureEmailInUse => 'An account already exists for that email.';

  @override
  String get failureWeakPassword => 'Please enter a stronger password.';

  @override
  String get failureInvalidCredential =>
      'The supplied credential is invalid or has expired.';

  @override
  String get failureAccountExistsDifferent =>
      'An account already exists with a different sign-in method.';

  @override
  String get failureCredentialInUse =>
      'This credential is already associated with a different user account.';

  @override
  String get failureSignInFallback =>
      'Please make sure your email and password are correct.';

  @override
  String get failureActionCodeExpired => 'The action code has expired.';

  @override
  String get failureActionCodeInvalid =>
      'The action code is invalid or has already been used.';

  @override
  String get failureActionUserNotFound =>
      'No user corresponding to the action code was found.';

  @override
  String get failureNewPasswordWeak => 'The new password is not strong enough.';

  @override
  String get failureSignOutFallback =>
      'An unknown error occurred while signing out.';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String get profileUserNotFoundTitle => 'User Data Not Found';

  @override
  String get profileUserNotFoundMessage =>
      'Unable to load user data. Please try again later or contact support.';

  @override
  String get profileUpdateSuccess => 'Profile Update Successful!';

  @override
  String get profileUpdateFailedTitle => 'Profile Update Failure';

  @override
  String get profileFirstName => 'First Name';

  @override
  String get profileLastName => 'Last Name';

  @override
  String get profileUpdateButton => 'Update Profile';

  @override
  String get profilePickImageError => 'Error picking image';

  @override
  String get profilePhotoGallery => 'Choose from Gallery';

  @override
  String get profilePhotoCamera => 'Take a Photo';

  @override
  String get profilePhotoRemove => 'Remove Photo';

  @override
  String get failureProfileFallback =>
      'An unknown error occurred while updating profile.';
}
