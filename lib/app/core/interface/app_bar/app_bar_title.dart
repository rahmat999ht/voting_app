import 'package:flutter/material.dart';
import 'package:packages/packages.dart';

import '../../colors/colors_app.dart';

AppBar appBarTitle({
  required String title,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    toolbarHeight: 70,
    automaticallyImplyLeading: false,
    backgroundColor: ColorApp.white.withOpacity(0),
    title: Row(
      children: [
        20.sH,
        Text(
          title,
          style: TextStyle(
            color: ColorApp.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
