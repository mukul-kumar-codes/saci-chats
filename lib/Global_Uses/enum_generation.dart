enum EmailSignUpResults{
  SignUpCompleted,
  EmailAlreadyPresent,
  SignUpNotCompleted,
}

enum EmailSignInResults{
  SignInCompleted,
  EmailOrPasswordInvalid,
  EmailNotVerified,
  UnexpectedError,
}

enum GoogleSignInResults{
  SignInCompleted,
  SignInNotCompleted,
  UnexpectedError,
  AlreadySignIn,
}

enum FBSignInResults{
  SignInCompleted,
  SignInNotCompleted,
  AlreadySignedIn,
  UnExpectedError,
}