import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/interface/alerts/alert_content.dart';

Future alertValueForm({
  final String? title,
  final List? listValue,
  final TextEditingController? textC,
  // final Widget? child,
}) async {
  // return PortalTarget(
  //   visible: true,
  //   anchor: const Aligned(
  //     follower: Alignment.topLeft,
  //     target: Alignment.topRight,
  //   ),

  //   portalFollower: Material(
  //     elevation: 8,
  //     child: IntrinsicWidth(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: listValue!
  //             .map(
  //               (e) => InkWell(
  //                 onTap: () {
  //                   textC!.text = e;
  //                   Get.back();
  //                 },
  //                 child: Card(
  //                   color: Colors.grey.shade200,
  //                   child: SizedBox(
  //                     height: 40,
  //                     width: Get.width,
  //                     child: Center(child: Text(e)),
  //                   ),
  //                 ),
  //               ),
  //             )
  //             .toList(),
  //       ),
  //     ),
  //   ),
  //   child: child!,
  //   // child: RaisedButton(...),
  // );
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
                color: Colors.grey.shade200,
                child: SizedBox(
                  height: 40,
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
