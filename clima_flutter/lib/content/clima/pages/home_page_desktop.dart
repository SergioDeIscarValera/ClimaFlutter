import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/my_panel.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/home_body.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop(
      {Key? key, required this.homeController, required this.authController})
      : super(key: key);
  final HomeController homeController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: HomeBody(
            authController: authController,
            homeController: homeController,
          ),
        ),
        Flexible(
          flex: 1,
          child: MyPanel(
            color: MyColors.PRIMARY,
            homeController: homeController,
            authController: authController,
          ),
        ),
      ],
    );
  }
}
