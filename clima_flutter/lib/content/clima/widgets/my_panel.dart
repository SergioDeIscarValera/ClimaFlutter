import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/my_bar.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_of_localidades.dart';
import 'location_swicher_container.dart';
import 'main_info_card.dart';
import 'notifications_container.dart';

class MyPanel extends StatelessWidget {
  const MyPanel({
    super.key,
    required this.color,
    required this.homeController,
    required this.authController,
    this.isDrawer = false,
  });

  final AuthController authController;
  final HomeController homeController;
  final MyColors color;
  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.all(switch (MediaQuery.of(context).size.width) {
        >= 1350 => 40,
        >= 1450 => 20,
        >= 720 => 10,
        _ => 10,
      }),
      child: Column(
        children: [
          // Bar
          MyBar(
            color: color,
            searchController: homeController.searchController,
            isDrawer: isDrawer,
            homeController: homeController,
            authController: authController,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (homeController.search.isNotEmpty) {
                return SingleChildScrollView(
                  child: ListOfLocalidades(
                      homeController: homeController, color: color),
                );
              } else {
                return PageView(
                  controller: homeController.infoCardPageController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: MainInfoCard(
                            color: color,
                            homeController: homeController,
                          ),
                        ),
                      ],
                    ),
                    LocationSwicherContainer(
                      color: color,
                      homeController: homeController,
                    ),
                    NotificationsContainer(
                      color: color,
                      homeController: homeController,
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
