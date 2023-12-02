import 'dart:convert';

import 'package:ClimaFlutter/utils/api_key.dart';
import 'package:http/http.dart' as http;

class WeatherApiRepository {
  static final WeatherApiRepository _singleton =
      WeatherApiRepository._internal();

  factory WeatherApiRepository() {
    return _singleton;
  }

  WeatherApiRepository._internal();

  Future<http.Response> getMunicipios() async => await http.get(
        Uri.https("opendata.aemet.es", "/opendata/api/maestro/municipios",
            {"api_key": aemetApiKey}),
      );

  Future<http.Response> getPrediccionDiaria(String codMunicipio) async {
    final firstRequest = await http.get(
      Uri.https(
          "opendata.aemet.es",
          "/opendata/api/prediccion/especifica/municipio/diaria/$codMunicipio",
          {"api_key": aemetApiKey}),
    );

    return await http.get(
      Uri.parse(jsonDecode(firstRequest.body)["datos"]),
    );
  }

  Future<http.Response> getPrediccionHoraria(String codMunicipio) async {
    final firstRequest = await http.get(
      Uri.https(
          "opendata.aemet.es",
          "/opendata/api/prediccion/especifica/municipio/horaria/$codMunicipio",
          {"api_key": aemetApiKey}),
    );

    return await http.get(
      Uri.parse(jsonDecode(firstRequest.body)["datos"]),
    );
  }
}
