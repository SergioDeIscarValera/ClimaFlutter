import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.formKey,
    required this.label,
    required this.onPressed,
    this.fontSize = 16,
    required this.color,
    required this.isHovering,
  }) : super(key: key);

  final GlobalKey<FormState>? formKey;
  final String label;
  final Function() onPressed;
  final double fontSize;
  final MyColors color;
  final RxBool isHovering;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isHovering.value ? color.inverse : color.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onPressed,
          onHover: (value) => isHovering.value = value,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                label,
                // No uso MyTextStyles.p.textStyle porque no quiero que se aplique el modo claro/oscuro
                style: TextStyle(
                  color: MyColors.LIGHT.color,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
