import 'dart:convert';

import 'package:clima_console/models/notification_template.dart';
import 'package:clima_console/utils/api_key.dart';
import 'package:http/http.dart' as http;

class NotificationsFirebase {
  static final NotificationsFirebase _singleton =
      NotificationsFirebase._internal();

  factory NotificationsFirebase() {
    return _singleton;
  }

  NotificationsFirebase._internal();

  final String _collectionTokens = "tokens";
  final String _collectionNotifications = "notifications";

  Future<String?> getToken({required String email}) async {
    final String firebaseUrl = "$firebaseDocumentsUrl$_collectionTokens/$email";
    final response =
        await http.get(Uri.parse('$firebaseUrl?key=$firebaseApiKey'));
    if (response.statusCode != 200) {
      throw Exception("Error al obtener el token");
    }

    final Map<String, dynamic> decodedData =
        response.body == "null" ? {} : json.decode(response.body);
    if (decodedData.containsKey("fields")) {
      return decodedData["fields"]["token"]["stringValue"];
    }
    return null;
  }

  Future<List<String>> getUsersWithNotifications() async {
    final String firebaseUrl = "$firebaseDocumentsUrl$_collectionNotifications";
    final response =
        await http.get(Uri.parse('$firebaseUrl?key=$firebaseApiKey'));
    if (response.statusCode != 200) {
      throw Exception("Error al obtener los usuarios con notificaciones");
    }

    final Map<String, dynamic> decodedData =
        response.body == "null" ? {} : json.decode(response.body);
    final List<String> users = [];
    if (decodedData.containsKey("documents")) {
      for (var document in decodedData["documents"]) {
        final String email = document["name"].split("/")[6];
        users.add(email);
      }
    }
    return users;
  }

  Future<List<NotificationTemplate>?> getNotifications({
    required String email,
  }) async {
    final String firebaseUrl =
        "$firebaseDocumentsUrl$_collectionNotifications/$email";
    final response =
        await http.get(Uri.parse('$firebaseUrl?key=$firebaseApiKey'));
    if (response.statusCode != 200) {
      throw Exception("Error al obtener las notificaciones");
    }

    final Map<String, dynamic> decodedData =
        response.body == "null" ? {} : json.decode(response.body);
    final List<NotificationTemplate> notifications = [];
    if (decodedData.containsKey("fields")) {
      for (var notification in decodedData["fields"]["notifications"]
          ["arrayValue"]["values"]) {
        notifications.add(
            NotificationTemplate.fromJson(notification["mapValue"]["fields"]));
      }
    }
    return notifications;
  }

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    final Map<String, dynamic> notification = {
      'notification': {
        'title': title,
        'body': body,
      },
      'to': token,
    };
    final response = await http.post(
      Uri.parse(firebaseMessagingUrl),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'key=$firebaseMessaginKey'
      },
      //encoding: Encoding.getByName('utf-8'),
      body: json.encode(notification),
    );
    if (response.statusCode == 200) {
      print('Notificación enviada con éxito.');
    } else {
      print('Error al enviar la notificación: ${response.statusCode}');
    }
  }
}
/*
Usuario con token
{
  "token": "e2J4Y2JlZjMtZjQ5Zi00ZjU5LWEwZjUtZjQ5ZjQ5ZjQ5ZjQ5",
}

Puede haber usuarios que todavía no tengan token
*/

/*
"notifications": [
  {
  "municipio_cod": "01001",
  "type": "TEMPERATURE",
  "max": 10,
  "isActivated": false
  },
  {
    "municipio_cod": "01002",
    "type": "CLOUDINESS",
    "min": 10,
    "isActivated": false
  },
  {
    "municipio_cod": "01001",
    "type": "TEMPERATURE",
    "max": 45,
    "min": -5
    "isActivated": true
  }
]
*/