import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/auth/utils/validators_utils.dart';
import 'package:ClimaFlutter/content/auth/widgets/auth_base.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/my_button.dart';
import 'package:ClimaFlutter/widgets/my_text_input.dart';
import 'package:ClimaFlutter/widgets/responsive_layout.dart';
import 'package:ClimaFlutter/widgets/row_divider.dart';
import 'package:ClimaFlutter/widgets/simple_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SimpleScaffold(
        child: ForgotPasswordPageBase(
          formInputFlex: 10,
        ),
      ),
      tablet: SimpleScaffold(
        child: ForgotPasswordPageBase(),
      ),
      desktop: Scaffold(
        body: RowDivider(
          bgColor: MyColors.INFO.color,
          child: ForgotPasswordPageBase(),
        ),
      ),
    );
  }
}

class ForgotPasswordPageBase extends StatelessWidget {
  ForgotPasswordPageBase({
    Key? key,
    this.formInputFlex = 5,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final formValidator = FormValidator();
  final int formInputFlex;
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return AuthBase(
      title: "forgot_password".tr,
      icon: Icons.lock_open,
      iconColor: MyColors.INFO,
      formKey: _formKey,
      children: [
        Text(
          "forgot_password_text".tr,
          style: MyTextStyles.p.textStyle.copyWith(
            color: MyColors.INFO.color,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.PRIMARY.color,
          mainFlex: formInputFlex,
          child: MyTextInput(
            controller: authController.emailController,
            validator: formValidator.isValidEmail,
            hint: "login_email".tr,
            icon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.PRIMARY.color,
          child: MyButton(
            formKey: _formKey,
            label: "recover_password".tr,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authController.passwordReset();
              }
            },
            color: MyColors.INFO,
            isHovering: authController.isHoverLoginButton,
          ),
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.SECONDARY.color,
          sideFlex: 2,
          child: MyButton(
            label: "go_back".tr,
            onPressed: () {
              Get.back();
            },
            fontSize: 14,
            color: MyColors.PRIMARY,
            isHovering: authController.isHoverRegisterButton,
          ),
        ),
      ],
    );
  }
}
