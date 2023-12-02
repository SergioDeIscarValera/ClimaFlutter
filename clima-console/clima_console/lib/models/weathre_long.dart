import 'package:clima_console/models/weather_tipe.dart';
import 'package:clima_console/utils/math.dart';
import 'package:clima_console/utils/weather_utils.dart';

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
    temperaturaMedia =
        MathUtils().sum(temperaturaHora) ~/ temperaturaHora.length;
    sensTermicaMedia =
        MathUtils().sum(sensTermicaHora) ~/ sensTermicaHora.length;
    probPrecipitacionMedia =
        MathUtils().sum(probPrecipitacionHora) ~/ probPrecipitacionHora.length;
    vientoMedia = MathUtils().sum(vientoHora) ~/ vientoHora.length;
    nubesMedia = MathUtils().sum(nubesHora) ~/ nubesHora.length;
    nieveMedia = MathUtils().sum(nieveHora) ~/ nieveHora.length;
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

  @override
  String toString() {
    return 'WeatherLong{municipio: $municipio, provincia: $provincia, fecha: $fecha, uvMax: $uvMax, salidaSol: $salidaSol, puestaSol: $puestaSol, temperaturaMedia: $temperaturaMedia, sensTermicaMedia: $sensTermicaMedia, probPrecipitacionMedia: $probPrecipitacionMedia, vientoMedia: $vientoMedia, nubesMedia: $nubesMedia, nieveMedia: $nieveMedia}';
  }
}
