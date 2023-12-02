import 'package:ClimaFlutter/content/splash/structure/controllers/init_splash_controller.dart';
import 'package:get/get.dart';

class InitSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitSplashController>(() => InitSplashController());
  }
}
