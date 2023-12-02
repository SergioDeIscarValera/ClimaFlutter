import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generic_container.dart';

class SunriseSunsetContainer extends StatelessWidget {
  const SunriseSunsetContainer({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  final DateTime? sunrise;
  final DateTime? sunset;

  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      title: "sunrise_sunset_title".tr,
      titleColor: MyColors.CONTRARY,
      color: Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
      child: Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: [
          buildItem(Icons.wb_sunny_outlined, "sunrise_text".tr, sunrise),
          buildItem(Icons.nightlight_round, "sunset_text".tr, sunset),
        ],
      ),
    );
  }

  Widget buildItem(IconData icon, String textKey, DateTime? time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: MyColors.WARNING.color,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textKey,
              style: MyTextStyles.p.textStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              MyLocalizations.localeDateFormat(
                  "h:mm a", time ?? DateTime.now()),
              textAlign: TextAlign.start,
              style: MyTextStyles.p.textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
