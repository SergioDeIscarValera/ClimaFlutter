import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({
    Key? key,
    required this.imagePath,
    required this.onTap,
    required this.isHovering,
    this.size = 32,
  }) : super(key: key);

  final String imagePath;
  final Function() onTap;
  final double size;
  final RxBool isHovering;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isHovering.value ? Colors.grey[300] : Colors.grey[200],
          border: Border.all(width: 2, color: MyColors.INFO.color),
        ),
        duration: const Duration(milliseconds: 150),
        child: InkWell(
          onTap: onTap,
          onHover: (value) => isHovering.value = value,
          child: Container(
            padding: EdgeInsets.all(size / 2),
            child: Image.asset(
              imagePath,
              height: size,
            ),
          ),
        ),
      ),
    );
  }
}
