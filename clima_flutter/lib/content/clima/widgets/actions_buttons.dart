import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              homeController.isDarkMode.value =
                  !homeController.isDarkMode.value;
            },
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.CONTRARY.color,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                homeController.isDarkMode.value
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round,
                color: MyColors.CURRENT.color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Get.updateLocale(
              Get.locale?.languageCode == "es"
                  ? const Locale("en")
                  : const Locale("es"),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.CONTRARY.color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.translate,
              color: MyColors.CURRENT.color,
            ),
          ),
        ),
      ],
    );
  }
}
