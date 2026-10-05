/// Why a form value was rejected. Validators return this, and the screen
/// turns it into text in the user's language.
enum ValidationError {
  emailInvalid,
  passwordRequired,
  passwordTooShort,
  passwordNeedsUppercase,
  passwordNeedsLowercase,
  passwordNeedsNumber,
  passwordNeedsSpecial,
  confirmationRequired,
  passwordsDoNotMatch,
  valueRequired,
}
