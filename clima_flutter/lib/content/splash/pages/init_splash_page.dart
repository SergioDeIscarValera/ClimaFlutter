import 'package:flutter/material.dart';

class InitSplashPage extends StatelessWidget {
  const InitSplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
