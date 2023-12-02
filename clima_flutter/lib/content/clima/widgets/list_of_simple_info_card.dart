import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/content/clima/widgets/simple_info_card.dart';
import 'package:ClimaFlutter/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfSimpleInfoCard extends StatelessWidget {
  const ListOfSimpleInfoCard({
    super.key,
    required this.homeController,
    required this.scrollDirection,
  });

  final HomeController homeController;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
        crossAxisCount: 1,
        scrollDirection: scrollDirection,
        childAspectRatio: (1.5 / 1), // width / height
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          for (var weather in homeController.weekWeather)
            SimpleInfoCard(
              index: homeController.weekWeather.indexOf(weather),
              selected: homeController.weekdaySelected.value ==
                  homeController.weekWeather.indexOf(weather),
              weatherType: weather.weatherType,
              weakDay: MyLocalizations.localeDateFormat(
                "EEEE",
                weather.fecha,
              ),
              temperature: weather.temperaturaMedia,
              temMax: weather.temperaturaMax,
              temMin: weather.temperaturaMin,
            ),
        ],
      ),
    );
  }
}
