import 'package:ClimaFlutter/content/clima/models/weather_tipe.dart';
import 'package:ClimaFlutter/content/clima/utils/weather_utils.dart';
import 'package:collection/collection.dart';

class WeatherLong {
  final String municipio;
  final String provincia;
  final DateTime fecha;
  final List<int> temperaturaHora;
  final List<int> sensTermicaHora;
  final List<int> probPrecipitacionHora;
  final List<int> vientoHora;
  final List<int> nubesHora;
  final List<int> nieveHora;
  final int? uvMax;
  final DateTime? salidaSol;
  final DateTime? puestaSol;

  late int temperaturaMedia;
  late int sensTermicaMedia;
  late int probPrecipitacionMedia;
  late int vientoMedia;
  late int nubesMedia;
  late int nieveMedia;

  WeatherLong({
    required this.municipio,
    required this.provincia,
    required this.fecha,
    required this.temperaturaHora,
    required this.sensTermicaHora,
    required this.probPrecipitacionHora,
    required this.vientoHora,
    required this.nubesHora,
    required this.nieveHora,
    required this.salidaSol,
    required this.puestaSol,
    this.uvMax,
  }) {
    temperaturaMedia = temperaturaHora.sum ~/ temperaturaHora.length;
    sensTermicaMedia = sensTermicaHora.sum ~/ sensTermicaHora.length;
    probPrecipitacionMedia =
        probPrecipitacionHora.sum ~/ probPrecipitacionHora.length;
    vientoMedia = vientoHora.sum ~/ vientoHora.length;
    nubesMedia = nubesHora.sum ~/ nubesHora.length;
    nieveMedia = nieveHora.sum ~/ nieveHora.length;
  }

  factory WeatherLong.empty() {
    return WeatherLong(
      municipio: "Unknown",
      provincia: "Unknown",
      fecha: DateTime.now(),
      temperaturaHora: List.filled(24, 0),
      sensTermicaHora: List.filled(24, 0),
      probPrecipitacionHora: List.filled(24, 0),
      vientoHora: List.filled(24, 0),
      nubesHora: List.filled(24, 0),
      nieveHora: List.filled(24, 0),
      salidaSol: null,
      puestaSol: null,
    );
  }

  WeatherType get weatherType => WeatherUtils.getType(
        temperatura: temperaturaMedia,
        lluvia: probPrecipitacionMedia,
        viento: vientoMedia,
        nubes: nubesMedia,
      );
}
