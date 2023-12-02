import 'package:ClimaFlutter/content/auth/pages/email_verification_page.dart';
import 'package:ClimaFlutter/content/auth/pages/forgot_password_page.dart';
import 'package:ClimaFlutter/content/auth/pages/login_page.dart';
import 'package:ClimaFlutter/content/auth/pages/register_page.dart';
import 'package:ClimaFlutter/content/auth/structure/bindings/email_verification_binding.dart';
import 'package:ClimaFlutter/content/clima/pages/home_page.dart';
import 'package:ClimaFlutter/content/clima/structure/bindings/home_binding.dart';
import 'package:ClimaFlutter/content/splash/pages/init_splash_page.dart';
import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INIT_SPLASH.path,
      page: () => const InitSplashPage(),
    ),
    GetPage(
      name: Routes.LOGIN.path,
      page: () => const LoginPage(),
      //binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER.path,
      page: () => const RegisterPage(),
      //binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD.path,
      page: () => const ForgotPasswordPage(),
      //binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.EMAIL_VERIFICATION.path,
      page: () => const EmailVerificationPage(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: Routes.HOME.path,
      page: () => const HomePage(),
      binding: HomeBinding(),
      //bindings: [AuthBinding()],
    ),
  ];
}
