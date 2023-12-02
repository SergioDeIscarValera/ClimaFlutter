import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/home_body_movil.dart';
import 'package:ClimaFlutter/content/clima/widgets/my_panel.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile(
      {Key? key, required this.homeController, required this.authController})
      : super(key: key);
  final HomeController homeController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: homeController.mainMovilePageController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomeBodyMovil(
          authController: authController,
          homeController: homeController,
        ),
        MyPanel(
          color: MyColors.PRIMARY,
          homeController: homeController,
          authController: authController,
          isDrawer: true,
        ),
      ],
    );
  }
}
