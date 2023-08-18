import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/nav_bottom.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.sesionLogin.value == 'pemilih'
            ? controller.widgetOptions().elementAt(
                  controller.selectedIndex.value,
                )
            : controller.widgetOptions().elementAt(
                  controller.selectedIndex.value + 1,
                ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          sesiLogin: controller.sesionLogin.value,
          selectedIndex: controller.selectedIndex.value,
          onTabChange: (index) {
            controller.selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}
