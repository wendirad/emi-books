// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get languageName => 'አማርኛ';

  @override
  String get languageSystemDefault => 'የስልኩ ቋንቋ';

  @override
  String get settingsLanguageTitle => 'ቋንቋ';

  @override
  String get settingsLanguageSubtitle => 'የመተግበሪያውን ቋንቋ ይምረጡ';

  @override
  String get actionBack => 'ተመለስ';

  @override
  String get actionRetry => 'እንደገና ይሞክሩ';

  @override
  String get actionTryAgain => 'እንደገና ይሞክሩ';

  @override
  String get actionCancel => 'ተው';

  @override
  String get loadingTitle => 'በመጫን ላይ';

  @override
  String get loadingSubtitle => 'እባክዎ ትንሽ ይጠብቁ።';

  @override
  String get toggleThemeTooltip => 'ገጽታ ቀይር';

  @override
  String couldNotOpenLink(String url) {
    return '$urlን መክፈት አልተቻለም';
  }

  @override
  String get errorPageNotFoundTitle => 'ገጹ አልተገኘም!';

  @override
  String get errorPageNotFoundMessage =>
      'የሚፈልጉት ገጽ የጠፋ ይመስላል። እባክዎ ወደ ኋላ ይመለሱ ወይም ወደ መነሻ ገጽ ይሂዱ።';

  @override
  String get errorNoConnectionTitle => 'ግንኙነት የለም';

  @override
  String get errorNoConnectionMessage =>
      'ይቅርታ፣ ከበይነመረብ ጋር አልተገናኙም። እባክዎ ግንኙነትዎን ያረጋግጡና እንደገና ይሞክሩ።';

  @override
  String get errorMaintenanceTitle => 'በጥገና ላይ ነው';

  @override
  String get errorMaintenanceMessage =>
      'ይቅርታ፣ አገልግሎቱ አሁን በጥገና ላይ ነው። እባክዎ ቆይተው እንደገና ይሞክሩ።';

  @override
  String get errorNoDataTitle => 'ምንም መረጃ አልተገኘም!';

  @override
  String get errorNoDataMessage => 'ምንም አልተገኘም። ገጹን ያድሱ ወይም ወደ መነሻ ገጽ ይመለሱ።';

  @override
  String get errorUnknownTitle => 'የሆነ ችግር ተፈጥሯል';

  @override
  String get errorUnknownMessage =>
      'ይቅርታ፣ ያልታሰበ ችግር ተፈጥሯል። እባክዎ ቆይተው እንደገና ይሞክሩ።';

  @override
  String get navHome => 'መነሻ';

  @override
  String get navSettings => 'ቅንብሮች';

  @override
  String get splashSignIn => 'ግባ';

  @override
  String get splashCreateAccount => 'መለያ ይፍጠሩ';

  @override
  String get mottoFirstLead => 'ሁልጊዜ ';

  @override
  String get mottoFirstEmphasis => 'ዝግጁ';

  @override
  String get mottoSecondLead => 'ሁልጊዜ ';

  @override
  String get mottoSecondEmphasis => 'ባለሙያ';

  @override
  String get mottoSentenceEnd => '።';

  @override
  String get settingsTitle => 'ቅንብሮች';

  @override
  String get settingsErrorTitle => 'ይቅርታ!';

  @override
  String get settingsEditProfileTooltip => 'መገለጫ ያርትዑ';

  @override
  String get settingsNoEmail => 'ኢሜይል የለም';

  @override
  String get settingsGeneral => 'ጠቅላላ';

  @override
  String get settingsThemeTitle => 'ገጽታ';

  @override
  String get settingsThemeSubtitle => 'በብርሃን እና በጨለማ ገጽታ መካከል ይቀያይሩ';

  @override
  String get settingsAccount => 'መለያ';

  @override
  String get settingsPrivacyTitle => 'የግላዊነት መመሪያ';

  @override
  String get settingsPrivacySubtitle => 'የግላዊነት መመሪያችንን ያንብቡ';

  @override
  String get settingsTermsTitle => 'የአገልግሎት ደንቦች';

  @override
  String get settingsTermsSubtitle => 'የአገልግሎት ደንቦቻችንን ያንብቡ';

  @override
  String get settingsAboutTitle => 'ስለ መተግበሪያው';

  @override
  String get settingsAboutSubtitle => 'የመተግበሪያው ስሪት እና መረጃ';

  @override
  String get aboutFollowUs => 'ይከተሉን';

  @override
  String appVersion(String version) {
    return 'ስሪት $version';
  }

  @override
  String get authSignIn => 'ግባ';

  @override
  String get authSignUp => 'ተመዝገብ';

  @override
  String get authSignOut => 'ውጣ';

  @override
  String get fieldEmail => 'ኢሜይል';

  @override
  String get fieldCode => 'ባለ 6 አሃዝ ኮድ';

  @override
  String get fieldPassword => 'የይለፍ ቃል';

  @override
  String get fieldConfirmPassword => 'የይለፍ ቃሉን ያረጋግጡ';

  @override
  String get fieldBusinessName => 'የንግድ ስም';

  @override
  String get signInSuccess => 'በተሳካ ሁኔታ ገብተዋል';

  @override
  String get signInTitle => 'እንኳን ደህና መጡ';

  @override
  String get signInSubtitle => 'ወደ መለያዎ ይግቡ';

  @override
  String get signInNoAccountPrompt => 'መለያ የለዎትም?';

  @override
  String get signInFailedTitle => 'መግባት አልተሳካም';

  @override
  String get signInRememberEmail => 'ኢሜይሌን አስታውስ';

  @override
  String get signInForgotPassword => 'የይለፍ ቃል ረስተዋል?';

  @override
  String get signOutSuccess => 'በተሳካ ሁኔታ ወጥተዋል';

  @override
  String get signOutSubtitle => 'ከመለያዎ ይውጡ';

  @override
  String get signOutConfirmMessage => 'ከመለያዎ መውጣት እንደሚፈልጉ እርግጠኛ ነዎት?';

  @override
  String get passwordResetEmailSent => 'የይለፍ ቃል ማስተካከያ ኮድ ወደ ኢሜይልዎ ተልኳል።';

  @override
  String get passwordResetTitle => 'የይለፍ ቃልዎን ረስተዋል?';

  @override
  String get passwordResetSubtitle => 'ባለ 6 አሃዝ ኮድ በኢሜይል እንልክልዎታለን';

  @override
  String get passwordResetRememberPrompt => 'የይለፍ ቃልዎን ያስታውሳሉ?';

  @override
  String get passwordResetFailedTitle => 'የይለፍ ቃል ማስተካከል አልተሳካም';

  @override
  String get passwordResetConfirmationFailedTitle =>
      'የይለፍ ቃል ማስተካከያ ማረጋገጫ አልተሳካም';

  @override
  String get passwordResetSendButton => 'የማስተካከያ ኮድ ላክ';

  @override
  String get confirmResetSuccess => 'የይለፍ ቃል በተሳካ ሁኔታ ተስተካክሏል!';

  @override
  String get confirmResetSubtitle => 'አዲሱን የይለፍ ቃልዎን ያስገቡ';

  @override
  String get confirmResetCodeSubtitle => 'ወደ ኢሜይልዎ የተላከውን ባለ 6 አሃዝ ኮድ ያስገቡ';

  @override
  String get confirmResetVerifyButton => 'ኮዱን አረጋግጥ';

  @override
  String get confirmResetButton => 'የይለፍ ቃል አስተካክል';

  @override
  String get signUpSuccess => 'በተሳካ ሁኔታ ተመዝግበዋል';

  @override
  String get signUpTitle => 'ይመዝገቡ';

  @override
  String get signUpSubtitle => 'አዲስ መለያ ይፍጠሩ';

  @override
  String get signUpHasAccountPrompt => 'መለያ አለዎት?';

  @override
  String get signUpFailedTitle => 'መመዝገብ አልተሳካም';

  @override
  String get validationEmailInvalid => 'ትክክለኛ ኢሜይል ያስገቡ።';

  @override
  String get validationPasswordRequired => 'የይለፍ ቃል ያስፈልጋል';

  @override
  String get validationPasswordTooShort => 'የይለፍ ቃል ቢያንስ 8 ቁምፊዎች መሆን አለበት';

  @override
  String get validationPasswordUppercase => 'ቢያንስ አንድ ትልቅ የላቲን ፊደል (A-Z) ያካትቱ';

  @override
  String get validationPasswordLowercase => 'ቢያንስ አንድ ትንሽ የላቲን ፊደል (a-z) ያካትቱ';

  @override
  String get validationPasswordNumber => 'ቢያንስ አንድ ቁጥር ያካትቱ';

  @override
  String get validationPasswordSpecial => 'ቢያንስ አንድ ልዩ ምልክት ያካትቱ';

  @override
  String get validationConfirmRequired => 'እባክዎ የይለፍ ቃልዎን ያረጋግጡ';

  @override
  String get validationPasswordsMismatch => 'የይለፍ ቃሎቹ አይመሳሰሉም';

  @override
  String get validationValueRequired => 'ትክክለኛ እሴት ያስገቡ።';

  @override
  String get validationCodeInvalid => 'ባለ 6 አሃዝ ኮድ ያስገቡ።';

  @override
  String get failureUnknown => 'ያልታወቀ ችግር ተፈጥሯል።';

  @override
  String get failureNetwork => 'የአውታረ መረብ ችግር። እባክዎ የበይነመረብ ግንኙነትዎን ያረጋግጡ።';

  @override
  String get failureInternal => 'ውስጣዊ ችግር ተፈጥሯል። እባክዎ ቆይተው እንደገና ይሞክሩ።';

  @override
  String get failureUserDisabled => 'ይህ መለያ ታግዷል። እባክዎ እርዳታ ለማግኘት ድጋፍን ያግኙ።';

  @override
  String get failureOperationNotAllowed => 'ይህ ተግባር አይፈቀድም። እባክዎ ድጋፍን ያግኙ።';

  @override
  String get failureTooManyRequests => 'ብዙ ጥያቄዎች ቀርበዋል። እባክዎ ቆይተው እንደገና ይሞክሩ።';

  @override
  String get failureNoCurrentUser => 'አሁን የገባ ተጠቃሚ የለም።';

  @override
  String get failureRequiresRecentLogin =>
      'ይህ ተግባር የቅርብ ጊዜ ማረጋገጫ ይፈልጋል። እባክዎ እንደገና ይግቡ።';

  @override
  String get failureSessionExpired => 'ክፍለ ጊዜዎ አብቅቷል። እባክዎ እንደገና ይግቡ።';

  @override
  String get failureInvalidSessionCookie => 'የክፍለ ጊዜ ኩኪው ልክ አይደለም።';

  @override
  String get failureTokenRevoked => 'ክፍለ ጊዜው ተሰርዟል። እባክዎ እንደገና ይግቡ።';

  @override
  String get failureInvalidEmail => 'ኢሜይሉ ልክ አይደለም ወይም አጻጻፉ የተሳሳተ ነው።';

  @override
  String get failureEmailInUse => 'በዚህ ኢሜይል መለያ ቀድሞ አለ።';

  @override
  String get failureWeakPassword => 'እባክዎ ጠንካራ የይለፍ ቃል ያስገቡ።';

  @override
  String get failureInvalidCredential => 'የቀረበው ማረጋገጫ ልክ አይደለም ወይም አብቅቷል።';

  @override
  String get failureAccountExistsDifferent => 'መለያው በሌላ የመግቢያ ዘዴ ቀድሞ አለ።';

  @override
  String get failureCredentialInUse => 'ይህ ማረጋገጫ ከሌላ መለያ ጋር ቀድሞ ተያይዟል።';

  @override
  String get failureSignInFallback => 'እባክዎ ኢሜይልዎና የይለፍ ቃልዎ ትክክል መሆናቸውን ያረጋግጡ።';

  @override
  String get failureActionCodeExpired => 'የማረጋገጫ ኮዱ አብቅቷል።';

  @override
  String get failureActionCodeInvalid =>
      'የማረጋገጫ ኮዱ ልክ አይደለም ወይም ቀድሞ ጥቅም ላይ ውሏል።';

  @override
  String get failureActionUserNotFound => 'ከማረጋገጫ ኮዱ ጋር የሚዛመድ ተጠቃሚ አልተገኘም።';

  @override
  String get failureNewPasswordWeak => 'አዲሱ የይለፍ ቃል በቂ ጠንካራ አይደለም።';

  @override
  String get failureSignOutFallback => 'በመውጣት ላይ ሳለ ያልታወቀ ችግር ተፈጥሯል።';

  @override
  String get profileEditTitle => 'መገለጫ አርትዕ';

  @override
  String get profileUserNotFoundTitle => 'የተጠቃሚ መረጃ አልተገኘም';

  @override
  String get profileUserNotFoundMessage =>
      'የተጠቃሚውን መረጃ መጫን አልተቻለም። እባክዎ ቆይተው ይሞክሩ ወይም ድጋፍን ያግኙ።';

  @override
  String get profileUpdateSuccess => 'መገለጫው በተሳካ ሁኔታ ተዘምኗል!';

  @override
  String get profileUpdateFailedTitle => 'መገለጫውን ማዘመን አልተሳካም';

  @override
  String get profileFirstName => 'ስም';

  @override
  String get profileLastName => 'የአባት ስም';

  @override
  String get profileUpdateButton => 'መገለጫ አዘምን';

  @override
  String get profilePickImageError => 'ምስሉን መምረጥ አልተቻለም';

  @override
  String get profilePhotoGallery => 'ከማዕከለ ስዕላት ይምረጡ';

  @override
  String get profilePhotoCamera => 'ፎቶ አንሳ';

  @override
  String get profilePhotoRemove => 'ፎቶ አስወግድ';

  @override
  String get failureProfileFallback => 'መገለጫውን በማዘመን ላይ ሳለ ያልታወቀ ችግር ተፈጥሯል።';
}
