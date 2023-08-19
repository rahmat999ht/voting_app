import 'package:flutter/material.dart';
import 'package:packages/extensions/size_app.dart';

import '../../../core/colors/colors_app.dart';
import '../../../core/models/capres.dart';

class CardCapresPV extends StatelessWidget {
  const CardCapresPV({
    Key? key,
    required this.data,
    required this.onTap,
    required this.colors,
    required this.persen,
  }) : super(key: key);
  final CapresModel data;
  final Color colors;
  final String? persen;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorApp.white,
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
          border: Border.all(color: ColorApp.primary),
        ),
        width: 130,
        child: Column(
          children: [
            Text(
              "${data.nama}",
              style: const TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            5.sH,
            ClipOval(
              child: Image.network(
                "${data.foto}",
                fit: BoxFit.cover,
              ),
            ),
            5.sH,
            Card(
              color: ColorApp.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colors),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  persen ?? '0%',
                  style: TextStyle(
                    fontSize: 14,
                    color: colors,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
