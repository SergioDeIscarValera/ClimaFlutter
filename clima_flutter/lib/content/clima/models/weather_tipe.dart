import 'package:get/get.dart';

enum WeatherType {
  sunny,
  cloudy,
  rainy,
  snowy,
  cold,
  heatwave,
  foggy,
  thunderstorm,
  windy,
  unknown
}

extension WeatherTypeUtils on WeatherType {
  String get imageSrc {
    switch (this) {
      case WeatherType.sunny:
        return 'lib/assets/weathers/sunny.png';
      case WeatherType.cloudy:
        return 'lib/assets/weathers/cloudy.png';
      case WeatherType.rainy:
        return 'lib/assets/weathers/rainy.png';
      case WeatherType.snowy:
        return 'lib/assets/weathers/snowy.png';
      case WeatherType.cold:
        return 'lib/assets/weathers/cold.png';
      case WeatherType.heatwave:
        return 'lib/assets/weathers/heatwave.png';
      case WeatherType.foggy:
        return 'lib/assets/weathers/foggy.png';
      case WeatherType.thunderstorm:
        return 'lib/assets/weathers/thunderstorm.png';
      case WeatherType.windy:
        return 'lib/assets/weathers/windy.png';
      default:
        return 'lib/assets/weathers/unknown.png';
    }
  }

  String get description {
    switch (this) {
      case WeatherType.sunny:
        return "weather_sunny_description".tr;
      case WeatherType.cloudy:
        return "weather_cloudy_description".tr;
      case WeatherType.rainy:
        return "weather_rainy_description".tr;
      case WeatherType.snowy:
        return "weather_snowy_description".tr;
      case WeatherType.cold:
        return "weather_cold_description".tr;
      case WeatherType.heatwave:
        return "weather_heatwave_description".tr;
      case WeatherType.foggy:
        return "weather_foggy_description".tr;
      case WeatherType.thunderstorm:
        return "weather_thunderstorm_description".tr;
      case WeatherType.windy:
        return "weather_windy_description".tr;
      default:
        return "weather_unknown_description".tr;
    }
  }
}
