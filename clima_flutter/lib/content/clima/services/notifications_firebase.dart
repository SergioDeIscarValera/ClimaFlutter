import 'dart:developer';

import 'package:ClimaFlutter/content/clima/models/notification_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsFirebase {
  static final NotificationsFirebase _singleton =
      NotificationsFirebase._internal();

  factory NotificationsFirebase() {
    return _singleton;
  }

  NotificationsFirebase._internal();

  final _firebaseMessaging = FirebaseMessaging.instance;
  final String _collectionTokens = "tokens";
  final String _collectionNotifications = "notifications";

  Future<String?> getToken() async {
    await _firebaseMessaging.requestPermission();
    return await _firebaseMessaging.getToken();
  }

  Future<void> saveToken({required String? email}) async {
    if (email == null) return;
    var token = await getToken();
    log("token: $token");
    if (token == null) return;
    var docRef = await _getRefAndSnapshotToken(email: email);
    if (docRef.value == null) return;
    if (docRef.value!.exists) {
      await docRef.key.update({
        "token": token,
      });
    } else {
      await docRef.key.set({
        "token": token,
      });
    }
  }

  Future<MapEntry<DocumentReference, DocumentSnapshot<Object?>?>>
      _getRefAndSnapshotToken({required String email}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(_collectionTokens).doc(email);
    DocumentSnapshot<Object?> snapshot = await docRef.get();
    return MapEntry(docRef, snapshot.exists ? snapshot : null);
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log("Handling a background message: ${message.messageId}");
  }

  Future initLocalNotifications() async {}

  Future<void> initNotifications({
    required String? email,
  }) async {
    saveToken(email: email);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> addNotification(
      {required String? email,
      required NotificationTemplate newNotification}) async {
    if (email == null) return Future.value();
    _editNotifications(
      docRef: await _getRefAndSnapshotNotifi(email: email),
      acion: (notifications) => notifications..add(newNotification),
    );
  }

  Future<void> removeNotification(
      {required String? email,
      required NotificationTemplate notification}) async {
    if (email == null) return Future.value();
    _editNotifications(
      docRef: await _getRefAndSnapshotNotifi(email: email),
      acion: (notifications) => notifications..remove(notification),
    );
  }

  Future<void> changeIsActivatedNotification(
      {required String email,
      required NotificationTemplate notification,
      required bool value}) async {
    _editNotifications(
      docRef: await _getRefAndSnapshotNotifi(email: email),
      acion: (notifications) {
        notifications
            .firstWhere((element) => element == notification)
            .isActivated = value;
        return notifications;
      },
    );
  }

  Future<void> _editNotifications({
    required MapEntry<DocumentReference, DocumentSnapshot<Object?>?> docRef,
    required List<NotificationTemplate> Function(List<NotificationTemplate>)
        acion,
  }) async {
    //Use NotificationTemplate.fromJson (Map<String, dynamic> json)
    List<NotificationTemplate> notifications =
        docRef.value?.data() != null && docRef.value?["notifications"] != null
            ? (docRef.value?["notifications"] as List<dynamic>)
                .map((e) => NotificationTemplate.fromJson(e))
                .toList()
            : [];
    notifications = acion(notifications).toSet().toList(); // Remove duplicates
    if (docRef.value?.exists ?? false) {
      await docRef.key.update({
        "notifications": notifications.map((e) => e.toJson()).toList(),
      });
    } else {
      await docRef.key.set({
        "notifications": notifications.map((e) => e.toJson()).toList(),
      });
    }
  }

  Future<MapEntry<DocumentReference, DocumentSnapshot<Object?>?>>
      _getRefAndSnapshotNotifi({required String email}) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(_collectionNotifications)
        .doc(email);
    DocumentSnapshot<Object?> snapshot = await docRef.get();
    return MapEntry(docRef, snapshot.exists ? snapshot : null);
  }

  void addListener({
    required String? email,
    required Function(List<NotificationTemplate>?) callback,
  }) {
    if (email == null) return;
    FirebaseFirestore.instance
        .collection(_collectionNotifications)
        .doc(email)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (!snapshot.exists) return;
      var data = snapshot.data() as Map<String, dynamic>?;
      if (data == null || data["notifications"] == null) return;
      List<NotificationTemplate> notifications = data["notifications"] != null
          ? (data["notifications"] as List<dynamic>)
              .map((e) => NotificationTemplate.fromJson(e))
              .toList()
          : [];
      callback(notifications);
    });
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