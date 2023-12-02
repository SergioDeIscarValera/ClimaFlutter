import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/my_panel.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/widgets/responsive_layout.dart';
import 'package:ClimaFlutter/widgets/simple_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page_desktop.dart';
import 'home_page_mobile.dart';
import 'home_page_tablet.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    AuthController authController = Get.find();

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return ResponsiveLayout(
      widthTablet: 600,
      mobile: SimpleScaffold(
        scaffoldKey: scaffoldKey,
        floatingActionButton: () {
          if (GetPlatform.isWeb) {
            scaffoldKey.currentState?.openEndDrawer();
          } else {
            //If is mobile
            homeController.moveMainMovileToPage(index: 1);
          }
        },
        endDrawer: MyPanel(
          color: MyColors.PRIMARY,
          homeController: homeController,
          authController: authController,
          isDrawer: true,
        ),
        child: HomePageMobile(
          homeController: homeController,
          authController: authController,
        ),
      ),
      tablet: SimpleScaffold(
        scaffoldKey: scaffoldKey,
        endDrawer: MyPanel(
          color: MyColors.PRIMARY,
          homeController: homeController,
          authController: authController,
          isDrawer: true,
        ),
        child: HomePageTablet(
          homeController: homeController,
          authController: authController,
          endDrawer: true,
        ),
      ),
      desktop: Scaffold(
        body: HomePageDesktop(
          homeController: homeController,
          authController: authController,
        ),
      ),
    );
  }
}
