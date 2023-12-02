import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/actions_buttons.dart';
import 'package:ClimaFlutter/content/clima/widgets/list_of_simple_info_card.dart';
import 'package:ClimaFlutter/content/clima/widgets/sunrise_sunset_container.dart';
import 'package:ClimaFlutter/content/clima/widgets/timer_text.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/widgets/my_line_chart_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'credits_container.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.authController,
    required this.homeController,
    this.endDrawer = false,
    this.padding = 40,
  });

  final AuthController authController;
  final HomeController homeController;
  final bool endDrawer;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Text
                TimerText(
                  userName: homeController.username,
                  now: homeController.now,
                ),
                // Mode switcher
                Row(
                  children: [
                    ActionsButtons(homeController: homeController),
                    if (endDrawer)
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                //If is web
                                if (GetPlatform.isWeb) {
                                  Scaffold.of(context).openEndDrawer();
                                } else {
                                  //If is mobile
                                  homeController.moveMainMovileToPage(index: 1);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.CONTRARY.color,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.menu,
                                  color: MyColors.CURRENT.color,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListOfSimpleInfoCard(
                homeController: homeController,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child:
                      // Amanecer y atardecer
                      Column(
                    children: [
                      Obx(
                        () => SunriseSunsetContainer(
                          sunrise:
                              homeController.dayWeatherSelected.value.salidaSol,
                          sunset:
                              homeController.dayWeatherSelected.value.puestaSol,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CreditsContainer()
                    ],
                  ),
                ),

                const SizedBox(width: 20),
                // Temperatura sensacion termina por horas (dos lineas)
                Flexible(
                  flex: MediaQuery.of(context).size.width > 750 ? 2 : 1,
                  child: Obx(
                    () => MyLineChartContainer(
                      title: "temperature_per_hour_title".tr,
                      now: homeController.now.value,
                      titleLeft: (value) => value,
                      titleBottom: (value) => "$value:00",
                      lineTouchDataTooltip: (value) => "$valueº",
                      data: {
                        MyColors.PRIMARY.color: MapEntry(
                          "temperature".tr,
                          homeController
                              .dayWeatherSelected.value.temperaturaHora,
                        ),
                        MyColors.SECONDARY.color: MapEntry(
                          "termic_sensation".tr,
                          homeController
                              .dayWeatherSelected.value.sensTermicaHora,
                        ),
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
              () => MyLineChartContainer(
                titleLeft: (value) => value,
                now: homeController.now.value,
                titleBottom: (value) => "$value:00",
                lineTouchDataTooltip: (value) => value,
                title: "more_info_per_hour_title",
                data: {
                  MyColors.INFO.color: MapEntry(
                    "rain_probability".tr,
                    homeController
                        .dayWeatherSelected.value.probPrecipitacionHora,
                  ),
                  MyColors.WARNING.color: MapEntry(
                    "wind_speed".tr,
                    homeController.dayWeatherSelected.value.vientoHora,
                  ),
                  MyColors.SUCCESS.color: MapEntry(
                    "clouds".tr,
                    homeController.dayWeatherSelected.value.nubesHora,
                  ),
                  MyColors.DANGER.color: MapEntry(
                    "snow_probability".tr,
                    homeController.dayWeatherSelected.value.nieveHora,
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
