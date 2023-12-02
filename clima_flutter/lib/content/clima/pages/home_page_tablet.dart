import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/home_body.dart';
import 'package:ClimaFlutter/content/clima/widgets/my_panel.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';

class HomePageTablet extends StatelessWidget {
  const HomePageTablet(
      {Key? key,
      required this.homeController,
      required this.authController,
      required this.endDrawer})
      : super(key: key);
  final HomeController homeController;
  final AuthController authController;
  final bool endDrawer;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: homeController.mainMovilePageController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomeBody(
          authController: authController,
          homeController: homeController,
          endDrawer: endDrawer,
          padding: 20,
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
