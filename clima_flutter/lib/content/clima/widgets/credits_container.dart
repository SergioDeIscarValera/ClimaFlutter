import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditsContainer extends StatelessWidget {
  const CreditsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      title: "credits_title".tr,
      titleColor: MyColors.CONTRARY,
      color: Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
      child: Text(
        "credits_text".tr,
        style: MyTextStyles.p.textStyle,
      ),
    );
  }
}
