import 'dart:ui';

import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/firebase_options.dart';
import 'package:ClimaFlutter/routes/app_pages.dart';
import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:ClimaFlutter/themes/thrmes.dart';
import 'package:ClimaFlutter/utils/localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: "clima-flutter-db",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      //name: "clima-flutter-db",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clima Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.LOGIN.path,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(AuthController());
      }),

      // Para que funcione el scroll con el mouse (drag)
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),

      theme: Themes.LIGHT.data,
      darkTheme: Themes.DARK.data,
      themeMode: ThemeMode.light,
      //themeMode: ThemeMode.system,

      translations: MyLocalizations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('es', 'ES'),
    );
  }
}
