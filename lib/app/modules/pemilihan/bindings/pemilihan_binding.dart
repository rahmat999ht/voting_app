import 'package:get/get.dart';

import '../controllers/pemilihan_controller.dart';

class PemilihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilihanController>(
      () => PemilihanController(),
    );
  }
}
