import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final dashboardC = Get.find<DashboardController>();

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("idLogin", '');
    Get.offAllNamed(
      Routes.LOGIN,
    );
  }
}
