// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:get/get_connect/connect.dart';

class MhsProvider extends GetConnect {
  Future<Response> getUser(int stb, String pass) {
    final url =
        'https://service.undipa.ac.id/loginmhs.php?user=$stb&pass=$pass&api=071994';
    log(url);
    return get(url);
  }
}
