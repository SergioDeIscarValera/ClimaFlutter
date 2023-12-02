/*  sunny, ✔
  cloudy, ✔
  rainy, ✔
  snowy, ✔
  heatwave, ✔
  foggy,
  thunderstorm,
  windy, ✔
  unknown*/

import 'package:clima_console/models/weather_tipe.dart';

class WeatherUtils {
  static WeatherType getType({
    required int temperatura,
    required int lluvia,
    required int viento,
    required int nubes,
  }) {
    if (viento > 60) {
      return WeatherType.windy;
    }

    if (lluvia > 90) {
      return WeatherType.rainy;
    }

    if (nubes > 14) {
      return WeatherType.cloudy;
    }

    return switch (temperatura) {
      <= 0 => WeatherType.snowy,
      <= 15 => WeatherType.cold,
      <= 40 => WeatherType.sunny,
      > 40 => WeatherType.heatwave,
      _ => WeatherType.unknown,
    };
  }
}
