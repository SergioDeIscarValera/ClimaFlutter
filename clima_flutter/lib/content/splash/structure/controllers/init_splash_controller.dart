import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:get/get.dart';

class InitSplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // Do something

    // Then redirect to login page
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(Routes.LOGIN.path);
    });
  }
}
