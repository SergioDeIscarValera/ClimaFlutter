import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/my_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'generic_container.dart';

class MyLineChartContainer extends StatelessWidget {
  MyLineChartContainer({
    super.key,
    required this.data,
    required this.titleLeft,
    required this.titleBottom,
    required this.lineTouchDataTooltip,
    this.now,
    TextStyle? bottomTitlesTextStyle,
    TextStyle? leftTitlesTextStyle,
    required this.title,
    this.height = 250,
    Color? backgroundColor,
  }) {
    this.bottomTitlesTextStyle = bottomTitlesTextStyle ??
        MyTextStyles.p.textStyle.copyWith(
          fontSize: 13,
        );
    this.leftTitlesTextStyle = leftTitlesTextStyle ?? MyTextStyles.p.textStyle;
    this.backgroundColor = backgroundColor ??
        (Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!);
  }

  final String title;
  final double height;
  final DateTime? now;
  final Map<Color, MapEntry<String, List<int>>> data;
  final String Function(String) titleLeft;
  final String Function(String) titleBottom;
  final String Function(String) lineTouchDataTooltip;
  late Color backgroundColor;
  late TextStyle leftTitlesTextStyle;
  late TextStyle bottomTitlesTextStyle;

  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      title: title.tr,
      titleColor: MyColors.CONTRARY,
      color: backgroundColor,
      trailing: [
        for (var entry in data.entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: entry.key,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                entry.value.key.tr,
                style: MyTextStyles.p.textStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          )
      ],
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MyLineChart(
          now: now,
          backgroundColor: backgroundColor,
          titleLeft: titleLeft,
          titleBottom: titleBottom,
          lineTouchDataTooltip: lineTouchDataTooltip,
          data: data.map((key, value) => MapEntry(key, value.value)),
        ),
      ),
    );
  }
}
