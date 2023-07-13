import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilih.dart';

import '../constans/constans_app.dart';
import '../models/pemilihan.dart';

class MethodApp {
  DocumentReference<PemilihModel> pemilih(String idKamar) {
    return ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .doc(idKamar)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PemilihModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<PemilihanModel> pemilihan(String idKamar) {
    return ConstansApp.firestore
        .collection(ConstansApp.pemilihanCollection)
        .doc(idKamar)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PemilihanModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<CapresModel> capres(String idKamar) {
    return ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .doc(idKamar)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CapresModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }
}
