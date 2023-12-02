import 'package:ClimaFlutter/content/clima/models/meteorological_agents.dart';

class NotificationTemplate {
  final String municipioCod;
  final MeteorologicalAgents type;
  final int? min;
  final int? max;
  bool isActivated;

  NotificationTemplate({
    required this.municipioCod,
    required this.type,
    this.min,
    this.max,
    required this.isActivated,
  });

  factory NotificationTemplate.fromJson(Map<String, dynamic> json) {
    return NotificationTemplate(
      municipioCod: json['municipio_cod'],
      type: MeteorologicalAgents.values.byName(json['type']),
      min: json['min'] != null ? json['min'] as int : null,
      max: json['max'] != null ? json['max'] as int : null,
      isActivated: json['isActivated'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'municipio_cod': municipioCod,
      'type': type.key,
      'isActivated': isActivated,
    };
    if (min != null) {
      data['min'] = min;
    }
    if (max != null) {
      data['max'] = max;
    }
    if (min == null && max == null) {
      throw Exception('min and max can\'t be null at the same time');
    }
    return data;
  }

  @override
  String toString() {
    return 'NotificationTemplate{municipioCod: $municipioCod, type: $type, min: $min, max: $max, isActivated: $isActivated}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTemplate &&
          runtimeType == other.runtimeType &&
          municipioCod == other.municipioCod &&
          type == other.type &&
          min == other.min &&
          max == other.max;
}
/*
{
  "municipio_cod": "01001",
  "type": "TEMPERATURE",
  "min": 0,
  "max": 10,
  "isActivated": true
}
*/