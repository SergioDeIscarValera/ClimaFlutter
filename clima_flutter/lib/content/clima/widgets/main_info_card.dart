import 'package:ClimaFlutter/content/clima/models/weather_tipe.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/utils/localizations.dart';
import 'package:ClimaFlutter/widgets/table_spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generic_container.dart';

class MainInfoCard extends StatelessWidget {
  const MainInfoCard({
    super.key,
    required this.color,
    required this.homeController,
  });

  final HomeController homeController;
  final MyColors color;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GenericContainer(
        title: homeController.dayWeatherSelected.value.municipio,
        titleColor: MyColors.CONTRARY,
        color: MyColors.CURRENT.color,
        isShadow: false,
        padding: switch (MediaQuery.of(context).size.width) {
          >= 1450 => 40,
          >= 1200 => 20,
          >= 720 => 10,
          _ => 10,
        },
        leading: Container(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            Icons.location_on,
            color: color.color,
          ),
        ),
        trailing: [
          Tooltip(
            message: "locality_selected_pin_tooltip".tr,
            child: GestureDetector(
              onTap: () {
                homeController.setDefaultCodMunicipioSelected();
              },
              child: CircleAvatar(
                // Si es el default color normal si no el de enfasis
                backgroundColor: homeController.defaultCodMunicipio.value ==
                        homeController.codLocalidadSelected.value
                    ? MyColors.SECONDARY_EMPHSIS.color
                    : MyColors.SECONDARY.color,
                child: Icon(
                  Icons.push_pin,
                  color: MyColors.CURRENT.color,
                ),
              ),
            ),
          ),
          Tooltip(
            message: "locality_selected_switch_tooltip".tr,
            child: GestureDetector(
              onTap: () {
                homeController.moveInfoCardToPage(index: 1);
              },
              child: CircleAvatar(
                backgroundColor: color.color,
                child: Icon(
                  Icons.swap_horiz,
                  color: MyColors.CURRENT.color,
                ),
              ),
            ),
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  homeController.dayWeatherSelected.value.weatherType.imageSrc,
                  height: MediaQuery.of(context).size.height < 700 ? 120 : 180,
                ),
                const SizedBox(height: 20),
                //Date
                Text(
                  (homeController.dayWeatherSelected.value.fecha.day ==
                              homeController.now.value.day
                          ? "today_text".tr
                          : "${MyLocalizations.localeDateFormat("EEEE", homeController.dayWeatherSelected.value.fecha)}, ") +
                      MyLocalizations.localeDateFormat('d MMMM',
                          homeController.dayWeatherSelected.value.fecha),
                  style: MyTextStyles.p.textStyle.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                //Temperature
                Text(
                  "${homeController.dayWeatherSelected.value.temperaturaHora[homeController.now.value.hour]}°",
                  style: MyTextStyles.h3.textStyle.copyWith(
                    fontSize: 64,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                //Weather title
                Text(
                  homeController
                      .dayWeatherSelected.value.weatherType.description,
                  style: MyTextStyles.h3.textStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    //Wind
                    TableRow(
                      children: [
                        Icon(
                          Icons.air,
                          color: MyColors.CONTRARY.color,
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            thickness: 2,
                            color: color.color,
                          ),
                        ),
                        Text(
                          "${homeController.dayWeatherSelected.value.vientoHora[homeController.now.value.hour]} km/h",
                          style: MyTextStyles.p.textStyle.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    TableSpacer.rowSpacer(20, 3),
                    //Humidity
                    TableRow(
                      children: [
                        Icon(
                          Icons.water,
                          color: MyColors.CONTRARY.color,
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            thickness: 2,
                            color: color.color,
                          ),
                        ),
                        Text(
                          "${homeController.dayWeatherSelected.value.probPrecipitacionMedia}%",
                          style: MyTextStyles.p.textStyle.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
