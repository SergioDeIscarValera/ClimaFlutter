import 'package:ClimaFlutter/content/clima/models/meteorological_agents.dart';
import 'package:ClimaFlutter/content/clima/structure/controllers/home_controller.dart';
import 'package:ClimaFlutter/themes/colors.dart';
import 'package:ClimaFlutter/themes/styles/my_text_styles.dart';
import 'package:ClimaFlutter/widgets/generic_container.dart';
import 'package:ClimaFlutter/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewNotificationTemplateForm extends StatelessWidget {
  const NewNotificationTemplateForm({
    super.key,
    required this.color,
    required this.homeController,
  });

  final MyColors color;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      title: "notifications_add_title".tr,
      titleColor: MyColors.CONTRARY,
      color: MyColors.CURRENT.color,
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
              Get.back();
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
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Text(
                "notifications_municipio_title".tr,
                style: MyTextStyles.h3.textStyle,
              ),
              DropdownButton(
                isExpanded: true,
                autofocus: true,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                iconEnabledColor: color.color,
                iconDisabledColor: color.inverse,
                dropdownColor: MyColors.CURRENT.color,
                value: homeController.codMunicipioForm.value,
                items: homeController.userLocalidadesCod.keys
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          homeController.nameOfMunicipio(municipioCod: e),
                          style: MyTextStyles.p.textStyle,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  homeController.setCodMunicipioForm(value ?? "");
                },
              ),
              const SizedBox(height: 20),
              Text(
                "notifications_type_title".tr,
                style: MyTextStyles.h3.textStyle,
              ),
              DropdownButton(
                isExpanded: true,
                autofocus: true,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                iconEnabledColor: color.color,
                iconDisabledColor: color.inverse,
                dropdownColor: MyColors.CURRENT.color,
                value: homeController.meteorologicalAgents.value,
                items: MeteorologicalAgents.values
                    .map(
                      (e) => DropdownMenuItem<MeteorologicalAgents>(
                        value: e,
                        child: Text(
                          e.name,
                          style: MyTextStyles.p.textStyle,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  homeController.setMeteorologicAgent(
                      value ?? MeteorologicalAgents.values[0]);
                },
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "notifications_max_title".tr,
                      style: MyTextStyles.h3.textStyle,
                    ),
                    Tooltip(
                      message: "notifications_checkbox_tooltip".tr,
                      child: Checkbox(
                        checkColor: MyColors.CURRENT.color,
                        activeColor: MyColors.DANGER.color,
                        value: homeController.isMaxActivated.value,
                        onChanged: (value) {
                          homeController.changeIsMaxActivated();
                        },
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  "notifications_subtitle".tr,
                  style: MyTextStyles.p.textStyle,
                ),
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Slider(
                      activeColor: MyColors.DANGER.color,
                      value: homeController.maxRangeForm.value,
                      min: homeController.meteorologicalAgents.value.min,
                      max: homeController.meteorologicalAgents.value.max,
                      divisions:
                          homeController.meteorologicalAgents.value.max.toInt(),
                      label:
                          homeController.maxRangeForm.value.toInt().toString(),
                      onChanged: (value) {
                        homeController.setMaxRangeForm(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "notifications_min_title".tr,
                      style: MyTextStyles.h3.textStyle,
                    ),
                    Tooltip(
                      message: "notifications_checkbox_tooltip".tr,
                      child: Checkbox(
                        checkColor: MyColors.CURRENT.color,
                        activeColor: MyColors.INFO.color,
                        value: homeController.isMinActivated.value,
                        onChanged: (value) {
                          homeController.changeIsMinActivated();
                        },
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  "notifications_subtitle".tr,
                  style: MyTextStyles.p.textStyle,
                ),
                children: [
                  Slider(
                    activeColor: MyColors.INFO.color,
                    value: homeController.minRangeForm.value,
                    min: homeController.meteorologicalAgents.value.min,
                    max: homeController.meteorologicalAgents.value.max,
                    divisions:
                        homeController.meteorologicalAgents.value.max.toInt(),
                    label: homeController.minRangeForm.value.toInt().toString(),
                    onChanged: (value) {
                      homeController.setMinRangeForm(value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyButton(
                label: "notifications_add_title".tr,
                onPressed: () {
                  homeController.addNotification();
                },
                color: color,
                isHovering: false.obs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
