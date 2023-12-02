import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_box_styles.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class GenericContainer extends StatelessWidget {
  const GenericContainer({
    super.key,
    required this.title,
    required this.titleColor,
    required this.color,
    this.padding = 24,
    this.isShadow = true,
    this.leading,
    this.trailing,
    this.trailingAlignment,
    required this.child,
  });

  final String title;
  final Color color;
  final MyColors titleColor;
  final double padding;
  final Widget child;
  final Widget? leading;
  final MainAxisAlignment? trailingAlignment;
  final List<Widget>? trailing;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isShadow ? MyBoxStyles.defaultShadow : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 0.5,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leading != null) leading!,
                    Text(
                      title,
                      style: MyTextStyles.h3.textStyle.copyWith(
                        color: titleColor.color,
                      ),
                    ),
                  ],
                ),
                if (trailing != null)
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: trailing!,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
