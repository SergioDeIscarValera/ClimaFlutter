enum Routes {
  INIT_SPLASH,
  LOGIN,
  REGISTER,
  FORGOT_PASSWORD,
  NOT_FOUND,
  HOME,
  EMAIL_VERIFICATION,
}

extension RoutesPath on Routes {
  String get path {
    switch (this) {
      case Routes.INIT_SPLASH:
        return "/init-splash";
      case Routes.LOGIN:
        return "/auth/login";
      case Routes.REGISTER:
        return "/auth/register";
      case Routes.FORGOT_PASSWORD:
        return "/auth/forgot-password";
      case Routes.HOME:
        return "/home";
      default:
        return "/not-found";
    }
  }
}
