import 'package:ClimaFlutter/content/auth/structure/controllers/email_verification_controller.dart';
import 'package:ClimaFlutter/content/auth/widgets/auth_base.dart';
import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/my_button.dart';
import 'package:ClimaFlutter/widgets/responsive_layout.dart';
import 'package:ClimaFlutter/widgets/row_divider.dart';
import 'package:ClimaFlutter/widgets/simple_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const SimpleScaffold(
        child: EmailVerificationPageBase(
          formInputFlex: 10,
        ),
      ),
      tablet: const SimpleScaffold(
        child: EmailVerificationPageBase(),
      ),
      desktop: Scaffold(
        body: RowDivider(
          bgColor: MyColors.WARNING.color,
          child: const EmailVerificationPageBase(),
        ),
      ),
    );
  }
}

class EmailVerificationPageBase extends StatelessWidget {
  const EmailVerificationPageBase({Key? key, this.formInputFlex = 5})
      : super(key: key);
  final int formInputFlex;
  @override
  Widget build(BuildContext context) {
    EmailVerificationController controller = Get.find();
    return AuthBase(
      title: "email_verification_title".tr,
      icon: Icons.fingerprint,
      iconColor: MyColors.WARNING,
      children: [
        Text(
          "email_verification_text".tr,
          style: MyTextStyles.p.textStyle.copyWith(
            color: MyColors.WARNING.color,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.PRIMARY.color,
          child: MyButton(
            label: "email_verification_button".tr,
            onPressed: () {
              controller.manualyCheckEmailVerificationStatus();
            },
            color: MyColors.WARNING,
            isHovering: controller.isHoverResendButton,
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: Get.isDarkMode
                      ? MyColors.LIGHT.color
                      : MyColors.DARK.color,
                  thickness: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.SECONDARY.color,
          sideFlex: 2,
          child: MyButton(
            label: "login_button".tr,
            onPressed: () {
              Get.offNamed(Routes.LOGIN.path);
            },
            fontSize: 14,
            color: MyColors.PRIMARY,
            isHovering: controller.isHoverLoginButton,
          ),
        ),
        const SizedBox(height: 25),
        TextButton(
          onPressed: () {
            controller.sendVerificationEmail();
          },
          child: Text(
            "resend_email_verification".tr,
            style: TextStyle(
              color: MyColors.INFO.color,
            ),
          ),
        ),
      ],
    );
  }
}
