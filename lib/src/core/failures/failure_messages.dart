const String _unknownMessage = 'An unknown exception occurred.';

/// Messages for codes every feature can meet. A failure's own table wins over
/// these; unmatched codes fall back to the failure's default message.
const Map<String, String> _commonMessages = {
  'network-request-failed':
      'Network error. Please check your internet connection.',
  'internal-error': 'An internal error occurred. Please try again later.',
  'user-disabled':
      'This user has been disabled. Please contact support for help.',
  'operation-not-allowed': 'Operation is not allowed. Please contact support.',
  'too-many-requests': 'Too many requests. Please try again later.',
  'no-current-user': 'No user is currently signed in.',
  'requires-recent-login':
      'This operation requires recent authentication. Please sign in again.',
};

/// The user-facing message for [code]: the failure's [own] table first, then
/// the common messages, then [fallback].
String failureMessageFor(
  String? code,
  Map<String, String> own, {
  String fallback = _unknownMessage,
}) => own[code] ?? _commonMessages[code] ?? fallback;
