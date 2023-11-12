// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get_connect/connect.dart';

class MhsProvider extends GetConnect {
  // Get request
  Future<Response> getUser(int stb) =>
      get('https://service.undipa.ac.id/dtmhs.php?user=$stb&api=071994');
}

// {
//   "data": [
//     {
//       "stb": "191058",
//       "nmmhs": "NAHDA NURUL AIN",
//       "alm": "DESA PONGGIHA",
//       "email": "nahdanurulain01@gmail.com",
//       "nohp": ""
//     }
//   ]
// }

class MhsModel {
  final String stb;
  final String nmmhs;
  final String alm;
  final String email;
  final String? nohp;
  MhsModel({
    required this.stb,
    required this.nmmhs,
    required this.alm,
    required this.email,
    this.nohp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stb': stb,
      'nmmhs': nmmhs,
      'alm': alm,
      'email': email,
      'nohp': nohp,
    };
  }

  factory MhsModel.fromMap(Map<String, dynamic> map) {
    return MhsModel(
      stb: map['stb'] as String,
      nmmhs: map['nmmhs'] as String,
      alm: map['alm'] as String,
      email: map['email'] as String,
      nohp: map['nohp'] != null ? map['nohp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MhsModel.fromJson(String source) =>
      MhsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
