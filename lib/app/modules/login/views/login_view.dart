import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';

import '../../../core/colors/colors_app.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              50.sH,
              TextForm.isTitle(
                controller: controller.stbC,
                title: 'STB',
                isBorder: true,
                colorBorder: ColorApp.primary,
                labelColor: ColorApp.primary,
                isCheck: true,
              ),
              16.sH,
              TextForm.isTitle(
                controller: controller.passC,
                title: 'Password',
                isBorder: true,
                colorBorder: ColorApp.primary,
                labelColor: ColorApp.primary,
                isCheck: true,
              ),
              16.sH,
              TextForm.isTitle(
                onTap: controller.alertStatus,
                controller: controller.sessionLoginC,
                title: 'Session Login',
                isBorder: true,
                colorBorder: ColorApp.primary,
                labelColor: ColorApp.primary,
                isCheck: true,
                suffixIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: ColorApp.primary,
                ),
              ),
              ButtonPrymary(
                text: 'Login',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
