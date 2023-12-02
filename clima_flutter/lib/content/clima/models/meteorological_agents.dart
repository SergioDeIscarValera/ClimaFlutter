import 'package:get/get.dart';

enum MeteorologicalAgents {
  unknown,
  temperature,
  probPrecipitation,
  windSpeed,
  cloudiness,
  probSnow,
}

extension MeteorologicalAgentsUtils on MeteorologicalAgents {
  String get key {
    switch (this) {
      case MeteorologicalAgents.temperature:
        return "temperature";
      case MeteorologicalAgents.probPrecipitation:
        return "probPrecipitation";
      case MeteorologicalAgents.windSpeed:
        return "windSpeed";
      case MeteorologicalAgents.cloudiness:
        return "cloudiness";
      case MeteorologicalAgents.probSnow:
        return "probSnow";
      default:
        return "unknown";
    }
  }

  String get name {
    switch (this) {
      case MeteorologicalAgents.temperature:
        return "temperature_name".tr;
      case MeteorologicalAgents.probPrecipitation:
        return "prob_precipitation_name".tr;
      case MeteorologicalAgents.windSpeed:
        return "wind_speed_name".tr;
      case MeteorologicalAgents.cloudiness:
        return "cloudiness_name".tr;
      case MeteorologicalAgents.probSnow:
        return "prob_snow_name".tr;
      default:
        return "unknown_name".tr;
    }
  }

  double get min {
    switch (this) {
      case MeteorologicalAgents.temperature:
        return -15;
      case MeteorologicalAgents.probPrecipitation:
        return 0;
      case MeteorologicalAgents.windSpeed:
        return 0;
      case MeteorologicalAgents.cloudiness:
        return 0;
      case MeteorologicalAgents.probSnow:
        return 0;
      default:
        return 0;
    }
  }

  double get max {
    switch (this) {
      case MeteorologicalAgents.temperature:
        return 50;
      case MeteorologicalAgents.probPrecipitation:
        return 100;
      case MeteorologicalAgents.windSpeed:
        return 180;
      case MeteorologicalAgents.cloudiness:
        return 100;
      case MeteorologicalAgents.probSnow:
        return 100;
      default:
        return 100;
    }
  }
}
