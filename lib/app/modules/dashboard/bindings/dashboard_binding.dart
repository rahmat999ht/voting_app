import 'package:get/get.dart';
import 'package:voting_app/app/modules/hasil/controllers/hasil_controller.dart';
import 'package:voting_app/app/modules/home/controllers/home_controller.dart';
import 'package:voting_app/app/modules/pemilihan/controllers/pemilihan_controller.dart';
import 'package:voting_app/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(
      DashboardController(),
      permanent: true,
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PemilihanController>(
      () => PemilihanController(),
    );
    Get.lazyPut<HasilController>(
      () => HasilController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
