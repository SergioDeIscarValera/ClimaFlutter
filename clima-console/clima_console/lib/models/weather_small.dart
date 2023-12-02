import 'package:clima_console/models/weather_tipe.dart';
import 'package:clima_console/utils/weather_utils.dart';

class WeatherSmall {
  final String municipio;
  final String provincia;
  final DateTime fecha;
  final int temperaturaMin;
  final int temperaturaMax;
  final int probPrecipitacion;
  final int viento;
  final int nubes;
  final String estadoCielo;

  late int temperaturaMedia;
  late WeatherType weatherType;

  WeatherSmall({
    required this.municipio,
    required this.provincia,
    required this.fecha,
    required this.temperaturaMin,
    required this.temperaturaMax,
    required this.probPrecipitacion,
    required this.viento,
    required this.nubes,
    required this.estadoCielo,
  }) {
    temperaturaMedia = (temperaturaMin + temperaturaMax) ~/ 2;

    weatherType = WeatherUtils.getType(
        temperatura: temperaturaMedia,
        lluvia: probPrecipitacion,
        viento: viento,
        nubes: nubes);
  }
}
