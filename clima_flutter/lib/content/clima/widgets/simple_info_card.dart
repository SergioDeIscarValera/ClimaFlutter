import 'package:ClimaFlutter/content/clima/models/weather_tipe.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleInfoCard extends StatelessWidget {
  const SimpleInfoCard({
    super.key,
    required this.weatherType,
    required this.weakDay,
    required this.temperature,
    required this.temMin,
    required this.temMax,
    required this.index,
    required this.selected,
  });

  final WeatherType weatherType;
  final String weakDay;
  final int temperature;
  final int temMin;
  final int temMax;
  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          controller.weekdaySelected.value = index;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? selected
                    ? MyColors.SECONDARY.color
                    : Colors.grey[800]
                : selected
                    ? MyColors.INFO.color
                    : Colors.grey[200],
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(child: Image.asset(weatherType.imageSrc)),
              const SizedBox(height: 10),
              Text(
                weakDay,
                style: MyTextStyles.h3.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "$temperature°",
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "$temMax°",
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: selected
                          ? MyColors.CONTRARY.color
                          : MyColors.DANGER.color,
                    ),
                  ),
                  Text(
                    "$temMin°",
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: selected
                          ? MyColors.CURRENT.color
                          : MyColors.INFO.color,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
