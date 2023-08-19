import 'package:get/get.dart';
import 'package:voting_app/app/modules/home/controllers/control_pem_controller.dart';

import '../../hasil/controllers/hasil_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../pemilihan/controllers/pemilih_controller.dart';
import '../../pemilihan/controllers/pemilihan_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(
      DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PemilihanController>(
      () => PemilihanController(),
    );
    Get.lazyPut<PemilihController>(
      () => PemilihController(),
    );
    Get.lazyPut<HasilController>(
      () => HasilController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<ControlPemController>(
      () => ControlPemController(),
    );
  }
}
