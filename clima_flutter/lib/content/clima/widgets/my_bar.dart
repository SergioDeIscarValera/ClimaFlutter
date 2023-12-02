import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBar extends StatelessWidget {
  const MyBar({
    super.key,
    required this.color,
    required this.searchController,
    required this.homeController,
    required this.authController,
    this.isDrawer = false,
  });

  final AuthController authController;
  final HomeController homeController;
  final MyColors color;
  final TextEditingController searchController;
  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (isDrawer)
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    //If is web
                    if (GetPlatform.isWeb) {
                      Scaffold.of(context).closeEndDrawer();
                    } else {
                      //If is mobile
                      homeController.moveMainMovileToPage(index: 0);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: MyColors.CURRENT.color,
                    child: Icon(
                      Icons.close,
                      color: color.color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        // Search location
        Expanded(
          child: SearchAnchor(builder: (context, controller) {
            return SearchBar(
              hintText: "search_location_hint".tr,
              controller: searchController,
              leading: Icon(
                Icons.search,
                color: color.color,
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (_) => MyColors.CURRENT.color,
              ),
              trailing: [
                Tooltip(
                  message: "search_location_remove_tooltip".tr,
                  child: GestureDetector(
                    onTap: () {
                      searchController.clear();
                    },
                    child: CircleAvatar(
                      backgroundColor: color.color,
                      child: Icon(
                        Icons.close,
                        color: MyColors.CURRENT.color,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }, suggestionsBuilder: (context, controller) {
            return List.empty();
          }),
        ),
        // Notifications
        const SizedBox(width: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              homeController.moveInfoCardToPage(index: 2);
            },
            child: CircleAvatar(
              backgroundColor: MyColors.CURRENT.color,
              child: Icon(
                Icons.notifications,
                color: color.color,
              ),
            ),
          ),
        ),
        // Profile
        const SizedBox(width: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              authController.signOut();
            },
            child: CircleAvatar(
              backgroundColor: MyColors.CURRENT.color,
              child: Icon(
                Icons.logout,
                color: color.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
