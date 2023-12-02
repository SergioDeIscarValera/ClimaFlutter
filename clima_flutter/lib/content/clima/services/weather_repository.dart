import 'dart:convert';

import 'package:ClimaFlutter/content/clima/models/dto/weathre_dto.dart';
import 'package:ClimaFlutter/content/clima/services/weather_api_repository.dart';
import 'package:http/http.dart';

class WeatherRepository {
  static final WeatherRepository _singleton = WeatherRepository._internal();

  factory WeatherRepository() {
    return _singleton;
  }

  WeatherRepository._internal();

  Future<Map<String, String>?> getMunicipios() async {
    try {
      Response bodyResponse = await WeatherApiRepository().getMunicipios();
      final body = bodyResponse.body;

      Map<String, String> municipios = {};
      for (var municipio in jsonDecode(body)) {
        municipios[municipio["nombre"].toString().toLowerCase()] =
            municipio["id"].toString().substring(2);
      }

      return municipios;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getMunicipioCode(String municipio) async {
    try {
      Map<String, String>? municipios = await getMunicipios();
      return municipios![municipio.toLowerCase()];
    } catch (e) {
      return null;
    }
  }

  Future<WeatherDto?> getWeekWeather(String codMunicipio) async {
    try {
      Response bodyResponse =
          await WeatherApiRepository().getPrediccionDiaria(codMunicipio);
      final body = bodyResponse.body;
      return WeatherDto.fromJson((jsonDecode(body) as List)[0], 0);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<WeatherDto?> getHourlyWeathre(String codMunicipio) async {
    try {
      Response bodyResponse =
          await WeatherApiRepository().getPrediccionHoraria(codMunicipio);
      final body = bodyResponse.body;
      return WeatherDto.fromJson((jsonDecode(body) as List)[0], 1);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
