import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
    required this.userName,
    required this.now,
  });

  final Rx<DateTime> now;
  final RxString userName;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MyLocalizations.localeDateFormat("h:mm a", now.value),
            style: MyTextStyles.h1.textStyle,
          ),
          const SizedBox(height: 5),
          Text(
            MyLocalizations.localeDateFormat('EEEE, d, MMMM, y', now.value),
            style: MyTextStyles.p.textStyle.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                now.value.hour > 12 ? Icons.dark_mode : Icons.light_mode,
                color: MyColors.SECONDARY.color,
              ),
              const SizedBox(width: 10),
              Wrap(
                direction: MediaQuery.of(context).size.width < 400
                    ? Axis.vertical
                    : Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: [
                  Text(
                    _getGoodTime(now.value.hour),
                    style: MyTextStyles.h2.textStyle.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "$userName!",
                    style: MyTextStyles.h2.textStyle.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getGoodTime(int hour) {
    return switch (hour) {
      >= 0 && < 6 => 'good_night'.tr,
      >= 6 && < 12 => 'good_morning'.tr,
      >= 12 && < 19 => 'good_afternoon'.tr,
      _ => 'good_evening'.tr,
    };
  }
}
