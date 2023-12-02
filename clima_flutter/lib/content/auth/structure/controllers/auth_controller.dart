import 'dart:developer';

import 'package:ClimaFlutter/content/auth/errors/auth_errors.dart';
import 'package:ClimaFlutter/content/auth/services/auth_firebase_repository.dart';
import 'package:ClimaFlutter/content/clima/services/notifications_firebase.dart';
import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:ClimaFlutter/utils/snakbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isHoverLoginButton = false.obs;
  final RxBool isHoverRegisterButton = false.obs;
  final RxBool isHoverForgotPasswordButton = false.obs;
  final RxBool isHoverGoogleButton = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Rxn<User?> _firebaseUser = Rxn<User?>();
  User? get firebaseUser => _firebaseUser.value;
  set firebaseUser(User? newValue) => _firebaseUser.value = newValue;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get user => _auth.authStateChanges();

  @override
  void onReady() {
    ever(_firebaseUser, handleAuthChanged);
    _firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(User? newUser) async {
    log("firebaseUser: $newUser");
    if (newUser == null || newUser.isAnonymous == true) {
      Get.offAllNamed(Routes.LOGIN.path);
      return;
    }

    if (newUser.emailVerified) {
      Get.offAllNamed(Routes.HOME.path);
      // Si es movil
      if (GetPlatform.isMobile) {
        NotificationsFirebase().initNotifications(
          email: newUser.email,
        );
      }
    } else {
      Get.offAllNamed(Routes.EMAIL_VERIFICATION.path);
    }
  }

  void loginWithEmailAndPassword() async {
    try {
      firebaseUser = await AuthFirebaseRepository().loginWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);
      MySnackBar.snackSuccess("login_success".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void registerWithEmailAndPassword({
    required Function onSuccess,
  }) async {
    if (passwordController.value.text != confirmPasswordController.value.text) {
      MySnackBar.snackError("passwords_not_match".tr);
      return;
    }
    try {
      firebaseUser = await AuthFirebaseRepository()
          .registerWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);
      onSuccess();
      MySnackBar.snackSuccess("register_success".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void loginWithGoogle() async {
    try {
      firebaseUser = await AuthFirebaseRepository().loginWithGoogle();
      MySnackBar.snackSuccess("login_google_success");
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void signOut() async {
    await _auth.signOut();
    firebaseUser = null;
  }

  void passwordReset() async {
    try {
      await AuthFirebaseRepository()
          .passwordReset(email: emailController.value.text);
      MySnackBar.snackSuccess("password_reset_send_success".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }
}
