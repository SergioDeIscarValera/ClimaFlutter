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

  String get nameFormated {
    switch (this) {
      case MeteorologicalAgents.temperature:
        return "temperatura";
      case MeteorologicalAgents.probPrecipitation:
        return "probabilidad de precipitación";
      case MeteorologicalAgents.windSpeed:
        return "velocidad del viento";
      case MeteorologicalAgents.cloudiness:
        return "nubosidad";
      case MeteorologicalAgents.probSnow:
        return "probabilidad de nieve";
      default:
        return "desconocido";
    }
  }
}
