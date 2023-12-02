import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLineChart extends StatelessWidget {
  MyLineChart({
    Key? key,
    required this.data,
    required this.titleLeft,
    this.now,
    required this.titleBottom,
    required this.lineTouchDataTooltip,
    TextStyle? bottomTitlesTextStyle,
    TextStyle? leftTitlesTextStyle,
    Color? backgroundColor,
  }) : super(key: key) {
    this.bottomTitlesTextStyle = bottomTitlesTextStyle ??
        MyTextStyles.p.textStyle.copyWith(
          fontSize: 13,
        );
    this.leftTitlesTextStyle = leftTitlesTextStyle ?? MyTextStyles.p.textStyle;
    this.backgroundColor = backgroundColor ??
        (Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!);
  }

  final Map<Color, List<int>> data;
  final String Function(String) titleLeft;
  final DateTime? now;
  final String Function(String) titleBottom;
  final String Function(String) lineTouchDataTooltip;
  late Color backgroundColor;
  late TextStyle leftTitlesTextStyle;
  late TextStyle bottomTitlesTextStyle;

  @override
  Widget build(BuildContext context) {
    var max = data.values.map((e) => e.max).max;
    var min = data.values.map((e) => e.min).min;
    return LineChart(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      LineChartData(
        minX: 0,
        maxX: 24,
        minY: ((min - 4) / 10).round() * 10,
        maxY: ((max + 10) / 10).round() * 10,
        backgroundColor: backgroundColor,
        borderData: FlBorderData(
          show: false,
        ),
        extraLinesData: ExtraLinesData(
          verticalLines: [
            if (now != null)
              VerticalLine(
                x: now!.hour.toDouble(),
                color: MyColors.CONTRARY.color,
                strokeWidth: 2,
              ),
          ],
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: false,
          getDrawingVerticalLine: (value) => FlLine(
            color: MyColors.CONTRARY.color.withOpacity(0.5),
            strokeWidth: 2,
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: MyColors.CONTRARY.color,
            tooltipRoundedRadius: 10,
            tooltipPadding: const EdgeInsets.all(10),
            tooltipMargin: 10,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                return LineTooltipItem(
                  //"${touchedSpot.y.toInt()}º",
                  lineTouchDataTooltip(touchedSpot.y.toString()),
                  MyTextStyles.p.textStyle.copyWith(
                      // Color de la linea
                      color: touchedSpot.bar.color),
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Transform.translate(
                offset: const Offset(0, 10),
                child: Text(
                  titleBottom(value.toString()),
                  style: bottomTitlesTextStyle,
                ),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Transform.translate(
                offset: const Offset(-10, 0),
                child: Text(
                  titleLeft(value.toString()),
                  style: leftTitlesTextStyle,
                ),
              ),
            ),
          ),
        ),
        lineBarsData: [
          for (var i = 0; i < data.length; i++)
            LineChartBarData(
              spots: [
                for (var j = 0; j < data.values.toList()[i].length; j++)
                  FlSpot(j.toDouble(), data.values.toList()[i][j].toDouble())
              ],
              isCurved: true,
              color: data.keys.toList()[i],
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    data.keys.toList()[i].withOpacity(0.3),
                    data.keys.toList()[i].withOpacity(0.1),
                  ],
                  stops: const [0.5, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
