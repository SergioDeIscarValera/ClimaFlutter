import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/actions_buttons.dart';
import 'package:ClimaFlutter/content/clima/widgets/credits_container.dart';
import 'package:ClimaFlutter/content/clima/widgets/list_of_simple_info_card.dart';
import 'package:ClimaFlutter/content/clima/widgets/sunrise_sunset_container.dart';
import 'package:ClimaFlutter/content/clima/widgets/timer_text.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/widgets/my_line_chart_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBodyMovil extends StatelessWidget {
  const HomeBodyMovil({
    Key? key,
    required this.authController,
    required this.homeController,
  }) : super(key: key);

  final AuthController authController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
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
                ActionsButtons(
                  homeController: homeController,
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListOfSimpleInfoCard(
                homeController: homeController,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SunriseSunsetContainer(
                sunrise: homeController.dayWeatherSelected.value.salidaSol,
                sunset: homeController.dayWeatherSelected.value.puestaSol,
              ),
            ),
            const SizedBox(height: 20),
            const CreditsContainer(),
            const SizedBox(height: 20),
            // Temperatura sensacion termina por horas (dos lineas)
            Obx(
              () => MyLineChartContainer(
                title: "temperature_per_hour_title".tr,
                now: homeController.now.value,
                titleLeft: (value) => value,
                titleBottom: (value) => "$value:00",
                lineTouchDataTooltip: (value) => "$valueº",
                data: {
                  MyColors.PRIMARY.color: MapEntry(
                    "temperature".tr,
                    homeController.dayWeatherSelected.value.temperaturaHora,
                  ),
                  MyColors.SECONDARY.color: MapEntry(
                    "termic_sensation".tr,
                    homeController.dayWeatherSelected.value.sensTermicaHora,
                  ),
                },
              ),
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
