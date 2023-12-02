import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generic_container.dart';

class ListOfLocalidades extends StatelessWidget {
  const ListOfLocalidades({
    super.key,
    required this.homeController,
    required this.color,
  });

  final HomeController homeController;
  final MyColors color;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          //for (var localidad in homeController.getLocalidadesFiltradas(10))
          for (var localidad in homeController.localidadesFiltradas.entries)
            Column(
              children: [
                GenericContainer(
                  title: localidad.key.capitalize!,
                  titleColor: MyColors.CONTRARY,
                  color: Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                  isShadow: false,
                  trailing: [
                    Tooltip(
                      message: "search_location_add_tooltip".tr,
                      child: GestureDetector(
                        onTap: () {
                          homeController.addCodMunicipio(localidad.value);
                        },
                        child: CircleAvatar(
                          backgroundColor: color.color,
                          child: Icon(
                            Icons.add,
                            color: MyColors.CURRENT.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: const SizedBox(),
                ),
                const SizedBox(height: 20),
              ],
            )
        ],
      ),
    );
  }
}
