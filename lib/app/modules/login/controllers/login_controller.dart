import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../components/alert_value_form.dart';

class LoginController extends GetxController {
  final stbC = TextEditingController();
  final passC = TextEditingController();
  final sessionLoginC = TextEditingController();

  final listSession = [
    'Mahasiswa',
    'Capres Bem',
  ];

  Future alertStatus() async {
    await alertValueForm(
      title: "Status",
      listValue: listSession,
      textC: sessionLoginC,
    );
  }
}
