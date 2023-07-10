import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/interface/alerts/alert_content.dart';

Future alertValueForm({
  final String? title,
  final List? listValue,
  final TextEditingController? textC,
}) async {
  return await alertContent(
    title: title!,
    content: Column(
      children: listValue!
          .map(
            (e) => InkWell(
              onTap: () {
                textC!.text = e;
                Get.back();
              },
              child: Card(
                color: ColorApp.black,
                child: SizedBox(
                  height: 30,
                  width: Get.width,
                  child: Center(child: Text(e)),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
