import 'dart:async';
import 'package:ClimaFlutter/content/auth/structure/controllers/auth_controller.dart';
import 'package:ClimaFlutter/content/clima/models/meteorological_agents.dart';
import 'package:ClimaFlutter/content/clima/models/notification_template.dart';
import 'package:ClimaFlutter/content/clima/models/weather_small.dart';
import 'package:ClimaFlutter/content/clima/models/weathre_long.dart';
import 'package:ClimaFlutter/content/clima/services/notifications_firebase.dart';
import 'package:ClimaFlutter/content/clima/services/weather_firebase_repository.dart';
import 'package:ClimaFlutter/content/clima/services/weather_repository.dart';
import 'package:ClimaFlutter/routes/app_routes.dart';
import 'package:ClimaFlutter/utils/snakbars.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Dia seleccionado
  final RxInt weekdaySelected = 0.obs;
  // Hora de ahora, se actualiza cada 5 segundos
  final Rx<DateTime> now = DateTime.now().obs;

  // Nombre del usuario
  RxString username = "".obs;

  // Datos del dia seleccionado
  final Rx<WeatherLong> dayWeatherSelected = WeatherLong.empty().obs;

  // Datos de la semana
  final RxList<WeatherSmall> weekWeather = <WeatherSmall>[].obs;
  // Datos de las horas
  final RxList<WeatherLong> longDataWeather = <WeatherLong>[].obs;

  // Estado del tema (POR REVISAR)
  final RxBool isDarkMode = Get.isDarkMode.obs;

  // Buscador de localidades
  final TextEditingController searchController = TextEditingController();
  // Texto del buscador, para que no de problemas con el Obx
  final RxString search = "".obs;

  // Localidades, CODIGO - NOMBRE
  final RxMap<String, String> localidades = <String, String>{}.obs;
  // Localidades filtradas, CODIGO - NOMBRE
  final RxMap<String, String> localidadesFiltradas = <String, String>{}.obs;
  // Localidades del usuario, CODIGO - WEATHERLONG
  final RxMap<String, WeatherLong> userLocalidadesCod =
      <String, WeatherLong>{}.obs;
  // Codigo de la localidad por defecto del usuario
  final RxString defaultCodMunicipio = "".obs;
  // Localidad seleccionada
  final RxString codLocalidadSelected = "".obs;

  // Controlador de la pagina principal cuando es movil
  final PageController mainMovilePageController =
      PageController(initialPage: 0, keepPage: true);

  // Controlador de la pagina de la infoCard
  final PageController infoCardPageController =
      PageController(initialPage: 0, keepPage: true);

  // Notificaciones del usuario
  final RxList<NotificationTemplate> notifications =
      <NotificationTemplate>[].obs;

  //Form
  final Rx<MeteorologicalAgents> meteorologicalAgents =
      MeteorologicalAgents.unknown.obs;
  final RxString codMunicipioForm = "".obs;
  final RxDouble maxRangeForm = 0.0.obs;
  final RxDouble minRangeForm = 0.0.obs;
  final RxBool isMaxActivated = false.obs;
  final RxBool isMinActivated = false.obs;
  //From end

  final AuthController authController = Get.find();

  // Madrid
  static const String _defaultIfDefaultIsNull = "28079";

  @override
  void onInit() async {
    // Empezamos el timer
    _startTimer();

    // Setear el dia de la semana seleccionado
    weekdaySelected.listen((value) {
      _setDayWeatherSelected();
    });

    // Setear la localidad seleccionada
    codLocalidadSelected.listen((value) {
      _updateWeekWeather(codMunicipio: value);
      _updateLongDataWeather(codMunicipio: value);
    });

    // Setear el tema
    isDarkMode.listen((value) {
      _changeTheme();
    });

    // Filtrar las localidades
    searchController.addListener(() {
      _filtrarLocalidadesFiltradas(6);
      search.value = searchController.text;
    });

    // filtrar las localidades cuando se añade una nueva, para quitarsela de las opciones
    userLocalidadesCod.listen((value) {
      _filtrarLocalidadesFiltradas(6);
    });

    defaultCodMunicipio.listen((codMunicipio) {
      if (codMunicipio == "") return;
      // Selecciona la localidad por defecto
      selectCodLocalidad(codMunicipio: defaultCodMunicipio.value);
    });

    // Evento cuando cambia el usuario
    authController.user.listen((event) async {
      if (event == null || event.email == null) return;
      username.value = event.displayName ?? event.email!;
      // Cargar el municipio por defecto
      defaultCodMunicipio.value = await WeatherFirebaseRepository()
          .getDefaultCodMunicipio(email: event.email);
      WeatherFirebaseRepository().addListener(
          email: event.email,
          callback: (newLocations) async => userLocalidadesCod.value =
              await _getWeatherOfListCodes(
                  codes: newLocations ?? [_defaultIfDefaultIsNull]));
      NotificationsFirebase().addListener(
        email: event.email,
        callback: (newNotifications) =>
            notifications.value = newNotifications ?? [],
      );

      // Cargar las localidades del usuario
      _loadUserLocalidades();
    });

    // Cargar las localidades
    _loadLocalidades();

    super.onInit();
  }

  void _startTimer() {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }

  // Funcion que actualiza los datos de la semana
  void _updateWeekWeather({
    String codMunicipio = _defaultIfDefaultIsNull,
  }) async {
    weekWeather.value =
        await WeatherRepository().getWeekWeather(codMunicipio).then((value) {
      return value?.castToWeatherSmallList() ?? [];
    });
  }

  // Funcion que actualiza los datos de las horas
  void _updateLongDataWeather({
    String codMunicipio = _defaultIfDefaultIsNull,
  }) async {
    longDataWeather.value = await WeatherRepository()
        .getHourlyWeathre(codMunicipio)
        .then((value) => value?.castToWeatherLongList() ?? []);

    dayWeatherSelected.value = longDataWeather[weekdaySelected.value];
  }

  // Funcion que actualiza los datos del dia seleccionado
  void _setDayWeatherSelected() {
    if (weekdaySelected.value < longDataWeather.length) {
      dayWeatherSelected.value = longDataWeather[weekdaySelected.value];
    } else {
      MySnackBar.snackError("no_weather_data".tr);
      weekdaySelected.value = 0;
    }
  }

  // Funcion que cambia el tema
  void _changeTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    // Si es web recarga la pagina para que se aplique el cambio de tema
    if (GetPlatform.isWeb) {
      Get.toNamed(Routes.HOME.path);
    }
  }

  // Funcion que carga las localidades
  void _loadLocalidades() async {
    localidades.value = await WeatherRepository().getMunicipios() ?? {};
  }

  // Funcion que carga las localidades del usuario
  void _loadUserLocalidades() async {
    userLocalidadesCod.value = await _getWeatherOfListCodes(
        codes: await WeatherFirebaseRepository().getUserLocalidades(
                email: authController.firebaseUser?.email) ??
            [_defaultIfDefaultIsNull]);

    if (userLocalidadesCod.isEmpty) return;

    codMunicipioForm.value = userLocalidadesCod.keys.first;
  }

  // Funcion que filtra las localidades
  _filtrarLocalidadesFiltradas(int count) {
    localidadesFiltradas.value = localidades.entries
        .where((element) => element.key
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .where((element) => !userLocalidadesCod.keys.contains(element.value))
        .take(count)
        .toList()
        .asMap()
        .map((key, value) => MapEntry(value.key, value.value));
  }

  // Funcion que setea la localidad por defecto del usuario
  void setDefaultCodMunicipio(String codMunicipio) async {
    if (codMunicipio == defaultCodMunicipio.value) return;

    if (await WeatherFirebaseRepository().setDefaultCodMunicipio(
      email: authController.firebaseUser?.email,
      codMunicipio: codMunicipio,
    )) {
      defaultCodMunicipio.value = codMunicipio;
      _loadUserLocalidades();
    } else {
      MySnackBar.snackError("no_weather_data".tr);
    }
  }

  // Funcion que setea la localidad seleccionada como la localidad por defecto
  void setDefaultCodMunicipioSelected() {
    setDefaultCodMunicipio(codLocalidadSelected.value);
  }

  // Funcion que añade una localidad al usuario
  void addCodMunicipio(String codMunicipio) async {
    await WeatherFirebaseRepository().addUserLocalidad(
      email: authController.firebaseUser?.email,
      codMunicipio: codMunicipio,
    );
  }

  // Funcion que elimina una localidad del usuario
  void removeCodMunicipio(String codMunicipio) async {
    if (codMunicipio == defaultCodMunicipio.value) {
      MySnackBar.snackError("cant_delete_default_location".tr);
      return;
    }
    if (codMunicipio == codLocalidadSelected.value) {
      MySnackBar.snackError("cant_delete_selected_location".tr);
      return;
    }
    await WeatherFirebaseRepository().removeUserLocalidad(
      email: authController.firebaseUser?.email,
      codMunicipio: codMunicipio,
    );
  }

  // Funcion que selecciona una localidad
  void selectCodLocalidad({required String codMunicipio}) {
    codLocalidadSelected.value = codMunicipio;
  }

  // Funcion que mueve la pagina principal
  void moveMainMovileToPage({required int index}) {
    mainMovilePageController.jumpToPage(index);
  }

  // Funcion que mueve la infoCard a una pagina
  void moveInfoCardToPage({required int index}) {
    infoCardPageController.jumpToPage(index);
  }

  // Funcion que obtiene el tiempo de una lista de codigos
  Future<Map<String, WeatherLong>> _getWeatherOfListCodes(
      {required List<String> codes}) async {
    return Map.fromEntries(await Future.wait(codes.map((e) =>
        WeatherRepository().getHourlyWeathre(e).then((value) => MapEntry(
            e, value?.castToWeatherLongList()[0] ?? WeatherLong.empty())))));
  }

  // Funcion que añade una notificacion
  Future<void> addNotification() async {
    if (meteorologicalAgents.value == MeteorologicalAgents.unknown) {
      MySnackBar.snackError("select_meteorological_agent".tr);
      return;
    }
    if (!isMaxActivated.value && !isMinActivated.value) {
      MySnackBar.snackError("select_max_min".tr);
      return;
    }
    NotificationTemplate notificationTemplate = NotificationTemplate(
      municipioCod: codMunicipioForm.value,
      type: meteorologicalAgents.value,
      min: isMinActivated.value ? minRangeForm.value.toInt() : null,
      max: isMaxActivated.value ? maxRangeForm.value.toInt() : null,
      isActivated: true,
    );
    await NotificationsFirebase().addNotification(
      email: authController.firebaseUser?.email,
      newNotification: notificationTemplate,
    );
    Get.back();
  }

  // Funcion que elimina una notificacion
  Future<void> removeNotification(
      {required NotificationTemplate notification}) async {
    await NotificationsFirebase().removeNotification(
      email: authController.firebaseUser?.email,
      notification: notification,
    );
  }

  // Funcion que cambia el estado de una notificacion
  Future<void> changeIsActivatedNotification({
    required NotificationTemplate notification,
    required bool value,
  }) async {
    await NotificationsFirebase().changeIsActivatedNotification(
      email: authController.firebaseUser!.email!,
      notification: notification,
      value: value,
    );
  }

  // Funcion que devuelve el nombre de un municipio
  String nameOfMunicipio({required String municipioCod}) {
    return localidades.entries
            .firstWhereOrNull((element) => element.value == municipioCod)
            ?.key
            .capitalize ??
        "";
  }

  // Funcion que setea el agente meteorologico, y actualiza los rangos
  void setMeteorologicAgent(MeteorologicalAgents value) {
    meteorologicalAgents.value = value;
    if (maxRangeForm.value > value.max) {
      maxRangeForm.value = value.max;
    }
    if (minRangeForm.value < value.min) {
      minRangeForm.value = value.min;
    }
  }

  void setCodMunicipioForm(String value) => codMunicipioForm.value = value;

  void setMaxRangeForm(double value) => maxRangeForm.value = value;

  void setMinRangeForm(double value) => minRangeForm.value = value;

  void changeIsMaxActivated() => isMaxActivated.value = !isMaxActivated.value;

  void changeIsMinActivated() => isMinActivated.value = !isMinActivated.value;
}
