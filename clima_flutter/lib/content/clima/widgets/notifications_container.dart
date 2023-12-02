import 'package:ClimaFlutter/content/clima/models/meteorological_agents.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_notification_template_form.dart';

class NotificationsContainer extends StatelessWidget {
  const NotificationsContainer(
      {Key? key, required this.color, required this.homeController})
      : super(key: key);
  final MyColors color;
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      title: "notifications_title".tr,
      titleColor: MyColors.CONTRARY,
      color: MyColors.CURRENT.color,
      isShadow: false,
      leading: Container(
        padding: const EdgeInsets.only(right: 5),
        child: Icon(
          Icons.notifications,
          color: color.color,
        ),
      ),
      trailing: [
        Tooltip(
          message: "go_back".tr,
          child: GestureDetector(
            onTap: () {
              homeController.moveInfoCardToPage(index: 0);
            },
            child: CircleAvatar(
              backgroundColor: color.color,
              child: Icon(
                Icons.arrow_back,
                color: MyColors.CURRENT.color,
              ),
            ),
          ),
        ),
        Tooltip(
          message: "notifications_add_tooltip".tr,
          child: GestureDetector(
            onTap: () {
              openNewNotificationDialog(
                context,
                color,
              );
            },
            child: CircleAvatar(
              backgroundColor: color.color,
              child: Icon(
                Icons.add,
                color: MyColors.CURRENT.color,
              ),
            ),
          ),
        )
      ],
      child: Expanded(
        child: Obx(
          () => ListView.builder(
            itemCount: homeController.notifications.length,
            itemBuilder: (BuildContext context, int index) {
              var notification = homeController.notifications[index];
              return Column(
                children: [
                  GenericContainer(
                    title: homeController.nameOfMunicipio(
                      municipioCod: notification.municipioCod,
                    ),
                    titleColor: MyColors.LIGHT,
                    color: color.color,
                    isShadow: false,
                    trailing: [
                      Tooltip(
                        message: "notifications_remove_tooltip".tr,
                        child: GestureDetector(
                          onTap: () {
                            homeController.removeNotification(
                                notification: notification);
                          },
                          child: CircleAvatar(
                            backgroundColor: MyColors.CURRENT.color,
                            child: Icon(
                              Icons.delete,
                              color: color.color,
                            ),
                          ),
                        ),
                      ),
                      Switch(
                        activeColor: MyColors.LIGHT.color,
                        inactiveThumbColor: MyColors.DANGER.color,
                        inactiveTrackColor: MyColors.DANGER.color,
                        value: notification.isActivated,
                        onChanged: (value) {
                          homeController.changeIsActivatedNotification(
                            notification: notification,
                            value: value,
                          );
                        },
                      ),
                    ],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            "${notification.type.name}:\n ${notification.min != null ? "Min: ${notification.min}" : ""} ${notification.max != null ? "Max: ${notification.max}" : ""}",
                            style: MyTextStyles.p.textStyle.copyWith(
                              color: MyColors.LIGHT.color,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
      /*child: Column(
        children: [
          for (var notification in homeController.notifications)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GenericContainer(
                  title: homeController.nameOfMunicipio(
                    municipioCod: notification.municipioCod,
                  ),
                  titleColor: MyColors.LIGHT,
                  color: color.color,
                  trailing: [
                    Tooltip(
                      message: "notifications_remove_tooltip".tr,
                      child: GestureDetector(
                        onTap: () {
                          homeController.removeNotification(
                              notification: notification);
                        },
                        child: CircleAvatar(
                          backgroundColor: MyColors.CURRENT.color,
                          child: Icon(
                            Icons.delete,
                            color: color.color,
                          ),
                        ),
                      ),
                    ),
                    Switch(
                      activeColor: MyColors.LIGHT.color,
                      inactiveThumbColor: MyColors.DANGER.color,
                      inactiveTrackColor: MyColors.DANGER.color,
                      value: notification.isActivated,
                      onChanged: (value) {
                        homeController.changeIsActivatedNotification(
                          notification: notification,
                          value: value,
                        );
                      },
                    ),
                  ],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          "${notification.type.name}:\n ${notification.min != null ? "Min: ${notification.min}" : ""} ${notification.max != null ? "Max: ${notification.max}" : ""}",
                          style: MyTextStyles.p.textStyle.copyWith(
                            color: MyColors.LIGHT.color,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          const SizedBox(height: 20),
          Tooltip(
            message: "notifications_add_tooltip".tr,
            child: GestureDetector(
              onTap: () {
                openNewNotificationDialog(
                  context,
                  color,
                );
              },
              child: CircleAvatar(
                backgroundColor: color.color,
                child: Icon(
                  Icons.add,
                  color: MyColors.CURRENT.color,
                ),
              ),
            ),
          ),
        ],
      ),*/
    );
  }

  Future openNewNotificationDialog(BuildContext context, MyColors color) async {
    return showDialog(
      context: context,
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            height: MediaQuery.of(context).size.height - 40,
            child: NewNotificationTemplateForm(
              homeController: homeController,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
