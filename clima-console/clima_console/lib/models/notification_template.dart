import 'package:clima_console/models/meteorological_agents.dart';

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
      municipioCod: json['municipio_cod']["stringValue"],
      type: MeteorologicalAgents.values.byName(json['type']["stringValue"]),
      min: json['min'] != null ? int.parse(json['min']["integerValue"]) : null,
      max: json['max'] != null ? int.parse(json['max']["integerValue"]) : null,
      isActivated: json['isActivated']["booleanValue"],
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
    return 'NotificationTemplate{municipioCod: $municipioCod, type: ${type.name}, min: $min, max: $max, isActivated: $isActivated}';
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
/*
{
  max: {integerValue: 99}, 
  isActivated: {booleanValue: true}, 
  municipio_cod: {stringValue: 45046}, 
  type: {stringValue: windSpeed}}
*/