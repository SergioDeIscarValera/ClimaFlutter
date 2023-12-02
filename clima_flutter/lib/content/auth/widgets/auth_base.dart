import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthBase extends StatelessWidget {
  const AuthBase({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.formKey,
    required this.children,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final List<Widget> children;
  final MyColors iconColor;

  final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            Text(
              "app_name".tr,
              style: MyTextStyles.h1.textStyle.copyWith(
                color: MyColors.PRIMARY.color,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              title,
              style: MyTextStyles.h2.textStyle.copyWith(
                color: MyColors.SECONDARY.color,
              ),
              textAlign: TextAlign.center,
            ),
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Icon(
                      icon,
                      size: 100,
                      color: iconColor.color,
                    ),
                    const SizedBox(height: 25),
                    for (var item in children) item,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
