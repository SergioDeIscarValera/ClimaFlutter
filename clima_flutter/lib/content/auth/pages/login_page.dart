import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/auth/utils/validators_utils.dart';
import 'package:ClimaFlutter/content/auth/widgets/auth_base.dart';
import 'package:ClimaFlutter/content/auth/widgets/square_tile.dart';
import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/my_button.dart';
import 'package:ClimaFlutter/widgets/my_text_input.dart';
import 'package:ClimaFlutter/widgets/responsive_layout.dart';
import 'package:ClimaFlutter/widgets/row_divider.dart';
import 'package:ClimaFlutter/widgets/simple_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SimpleScaffold(
        child: LoginPageBase(
          formInputFlex: 10,
        ),
      ),
      tablet: SimpleScaffold(
        child: LoginPageBase(),
      ),
      desktop: Scaffold(
        body: RowDivider(
          bgColor: MyColors.PRIMARY.color,
          child: LoginPageBase(),
        ),
      ),
    );
  }
}

class LoginPageBase extends StatelessWidget {
  LoginPageBase({
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
      title: "login_title".tr,
      icon: Icons.lock,
      iconColor: MyColors.PRIMARY,
      formKey: _formKey,
      children: [
        Text(
          "login_welcome".tr,
          style: MyTextStyles.h3.textStyle,
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
          mainFlex: formInputFlex,
          child: MyTextInput(
            controller: authController.passwordController,
            validator: formValidator.isValidPass,
            hint: "login_pass".tr,
            icon: const Icon(Icons.lock),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.PRIMARY.color,
          child: MyButton(
            formKey: _formKey,
            label: "login_button".tr,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authController.loginWithEmailAndPassword();
              }
            },
            color: MyColors.PRIMARY,
            isHovering: authController.isHoverLoginButton,
          ),
        ),
        const SizedBox(height: 25),
        RowDivider(
          bgColor: MyColors.PRIMARY.color,
          sideFlex: 2,
          child: MyButton(
            formKey: _formKey,
            label: "registration_button".tr,
            onPressed: () {
              Get.toNamed(Routes.REGISTER.path);
            },
            fontSize: 14,
            color: MyColors.SECONDARY,
            isHovering: authController.isHoverRegisterButton,
          ),
        ),
        const SizedBox(height: 25),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.FORGOT_PASSWORD.path);
          },
          child: Text(
            "forgot_password".tr,
            style: TextStyle(
              color: MyColors.INFO.color,
            ),
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
              Text(
                "dividar".tr,
                style: TextStyle(
                  color: Get.isDarkMode
                      ? MyColors.LIGHT.color
                      : MyColors.DARK.color,
                ),
              ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SquareTile(
              imagePath: "lib/assets/google.png",
              onTap: () {
                authController.loginWithGoogle();
              },
              isHovering: authController.isHoverGoogleButton,
            ),
          ],
        ),
      ],
    );
  }
}
