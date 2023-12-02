import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';

class SimpleScaffold extends StatelessWidget {
  const SimpleScaffold({
    Key? key,
    required this.child,
    this.scaffoldKey,
    this.endDrawer,
    this.floatingActionButton,
  }) : super(key: key);
  final Widget child;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? endDrawer;
  final Function? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Center(
          child: child,
        ),
      ),
      resizeToAvoidBottomInset: false,
      endDrawer: SizedBox(
        width: switch (MediaQuery.of(context).size.width) {
          >= 720 => 500,
          >= 600 => 300,
          _ => MediaQuery.of(context).size.width - 40,
        },
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: endDrawer,
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          if (floatingActionButton != null) {
            return FloatingActionButton(
              onPressed: () => floatingActionButton!(),
              backgroundColor: MyColors.CONTRARY.color,
              child: Icon(
                Icons.menu,
                color: MyColors.CURRENT.color,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
