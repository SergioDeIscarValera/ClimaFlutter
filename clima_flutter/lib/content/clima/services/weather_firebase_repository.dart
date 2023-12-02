import 'package:cloud_firestore/cloud_firestore.dart';

class WeatherFirebaseRepository {
  static final WeatherFirebaseRepository _singleton =
      WeatherFirebaseRepository._internal();

  factory WeatherFirebaseRepository() {
    return _singleton;
  }

  WeatherFirebaseRepository._internal();

  final String _collection = "localities";
  // Madrid
  final String _defaultIfDefaultIsNull = "28079";

  Future<String> getDefaultCodMunicipio({required String? email}) async {
    if (email == null) return _defaultIfDefaultIsNull;
    var docRef = await _getRefAndSnapshot(email: email);
    return docRef.value?['default'] ?? _defaultIfDefaultIsNull;
  }

  Future<List<String>?> getUserLocalidades({required String? email}) async {
    if (email == null) return null;
    var docRef = await _getRefAndSnapshot(email: email);
    return docRef.value?['localidades']?.cast<String>() ?? [];
  }

  Future<void> addUserLocalidad(
      {required String? email, required String codMunicipio}) async {
    if (email == null) return;
    _editLocalidades(
      docRef: await _getRefAndSnapshot(email: email),
      acion: (localidades) => localidades..add(codMunicipio),
    );
  }

  Future<void> removeUserLocalidad(
      {required String? email, required String codMunicipio}) async {
    if (email == null) return;
    _editLocalidades(
      docRef: await _getRefAndSnapshot(email: email),
      acion: (localidades) => localidades..remove(codMunicipio),
    );
  }

  Future<bool> setDefaultCodMunicipio({
    required String? email,
    required String codMunicipio,
  }) async {
    if (email == null) return false;
    var docRef = await _getRefAndSnapshot(email: email);
    if (!(docRef.value?['localidades'].cast<String>()).contains(codMunicipio)) {
      return false;
    }
    if (docRef.value?.exists ?? false) {
      await docRef.key.update({
        "default": codMunicipio,
      });
    } else {
      await docRef.key.set({
        "default": codMunicipio,
      });
    }
    return true;
  }

  Future<void> _editLocalidades({
    required MapEntry<DocumentReference, DocumentSnapshot<Object?>?> docRef,
    required List<String> Function(List<String>) acion,
  }) async {
    List<String> localidades = docRef.value?['localidades'].cast<String>() ??
        [_defaultIfDefaultIsNull];
    localidades = acion(localidades);
    if (docRef.value?.exists ?? false) {
      await docRef.key.update({
        "localidades": localidades,
      });
    } else {
      await docRef.key.set({
        "localidades": localidades,
      });
    }
  }

  Future<MapEntry<DocumentReference, DocumentSnapshot<Object?>?>>
      _getRefAndSnapshot({required String email}) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(_collection).doc(email);
      DocumentSnapshot<Object?> snapshot = await docRef.get();
      return MapEntry(docRef, snapshot.exists ? snapshot : null);
    } catch (e) {
      throw Exception("Error al obtener el usuario");
    }
  }

  void addListener({
    required String? email,
    required Function(List<String>?) callback,
  }) {
    if (email == null) return;
    FirebaseFirestore.instance
        .collection(_collection)
        .doc(email)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (!snapshot.exists) return;
      var data = snapshot.data() as Map<String, dynamic>?;
      if (data == null || data['localidades'] == null) return;
      callback(data['localidades']?.cast<String>());
    });
  }
}
/*
{
  "default": "28079",
  "localidades": [
    "28079",
    "28080",
    "28081",
    "28082",
    "28083",
  ]
}

// No default
{
  "localidades": [
    "28079",
    "28080",
    "28081",
    "28082",
    "28083",
  ]
}
*/