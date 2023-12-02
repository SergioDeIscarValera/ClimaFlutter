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
}
