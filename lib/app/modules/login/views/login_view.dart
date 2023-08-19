import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';
import 'package:voting_app/app/core/interface/app_bar/app_bar_title.dart';

import '../../../core/colors/colors_app.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(title: 'Login User'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 20.sH,
                // const FlutterLogo(size: 120),
                40.sH,
                TextForm.isTitle(
                  controller: controller.stbC,
                  title: 'STB',
                  hintText: 'STB',
                  isBorder: true,
                  colorFocusBorder: ColorApp.primary,
                  colorBorder: ColorApp.black.withOpacity(0.6),
                  labelColor: ColorApp.black.withOpacity(0.6),
                  isCheck: true,
                ),
                16.sH,
                Obx(
                  () => TextForm.isTitle(
                    controller: controller.passC,
                    title: 'Password',
                    hintText: 'Password',
                    isBorder: true,
                    colorFocusBorder: ColorApp.primary,
                    colorBorder: ColorApp.black.withOpacity(0.6),
                    labelColor: ColorApp.black.withOpacity(0.6),
                    obscureText: controller.isObscure.value,
                    suffixIcon: iconVisible(),
                    isCheck: true,
                  ),
                ),
                16.sH,
                TextForm.isTitle(
                  onTap: controller.alertStatus,
                  controller: controller.sessionLoginC,
                  title: 'Sesi Login',
                  hintText: 'Pilih Sesi Login',
                  isBorder: true,
                  colorFocusBorder: ColorApp.primary,
                  colorBorder: ColorApp.black.withOpacity(0.6),
                  labelColor: ColorApp.black.withOpacity(0.6),
                  isCheck: true,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: ColorApp.primary,
                  ),
                ),
                20.sH,
                Obx(
                  () => ButtonPrymary(
                    isLoading: controller.isLoading.value,
                    text: 'Login',
                    textColor: ColorApp.black,
                    bgColor: ColorApp.primary,
                    onPressed: controller.login,
                    height: 50,
                  ),
                ),
                20.sH,
                const Text(
                  'Info : ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                8.sH,
                const Text(
                  'Login menggunakan akun SIAKA anda',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell iconVisible() {
    return InkWell(
      onTap: controller.initObscure,
      child: Icon(
        controller.isObscure.value == true
            ? Icons.visibility
            : Icons.visibility_off,
        color: ColorApp.primary,
      ),
    );
  }
}
