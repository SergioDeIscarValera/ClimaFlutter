import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/widgets/my_line_chart_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generic_container.dart';

class LocationSwicherContainer extends StatelessWidget {
  const LocationSwicherContainer({
    super.key,
    required this.color,
    required this.homeController,
  });

  final MyColors color;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      title: "locality_selected_switch_title".tr,
      titleColor: MyColors.CONTRARY,
      color: MyColors.CURRENT.color,
      padding: switch (MediaQuery.of(context).size.width) {
        >= 1450 => 40,
        >= 1200 => 20,
        >= 720 => 10,
        _ => 10,
      },
      isShadow: false,
      leading: Container(
        padding: const EdgeInsets.only(right: 5),
        child: Icon(
          Icons.location_on,
          color: color.color,
        ),
      ),
      trailing: [
        Tooltip(
          message: "go_back".tr,
          child: GestureDetector(
            onTap: () {
              homeController.moveInfoCardToPage(index: 0);
            },
            child: CircleAvatar(
              backgroundColor: color.color,
              child: Icon(
                Icons.arrow_back,
                color: MyColors.CURRENT.color,
              ),
            ),
          ),
        ),
      ],
      child: Expanded(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.userLocalidadesCod.length,
            itemBuilder: (BuildContext context, int index) {
              var location =
                  homeController.userLocalidadesCod.keys.toList()[index];
              var weatherData = homeController.userLocalidadesCod[location];
              return Column(children: [
                GenericContainer(
                  title: weatherData!.municipio,
                  titleColor: MyColors.LIGHT,
                  color: color.color,
                  isShadow: false,
                  trailing: [
                    Tooltip(
                      message: "search_location_delete_tooltip".tr,
                      child: GestureDetector(
                        onTap: () {
                          homeController.removeCodMunicipio(location);
                        },
                        child: CircleAvatar(
                          backgroundColor: MyColors.CURRENT.color,
                          child: Icon(
                            Icons.delete,
                            color: color.color,
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: "search_location_delete_tooltip".tr,
                      child: GestureDetector(
                        onTap: () {
                          homeController.selectCodLocalidad(
                              codMunicipio: location);
                          homeController.moveInfoCardToPage(index: 0);
                        },
                        child: CircleAvatar(
                          backgroundColor: MyColors.CURRENT.color,
                          child: Icon(
                            Icons.done,
                            color: color.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: MyLineChartContainer(
                    height: 150,
                    title: "",
                    backgroundColor: MyColors.CURRENT.color,
                    titleLeft: (value) => value,
                    titleBottom: (value) => "$value:00",
                    lineTouchDataTooltip: (value) => "$valueº",
                    data: {
                      MyColors.INFO.color: MapEntry(
                        "temperature".tr,
                        weatherData.temperaturaHora,
                      ),
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
