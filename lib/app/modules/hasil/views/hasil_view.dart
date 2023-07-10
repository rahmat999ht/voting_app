import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:get/get.dart';
import 'package:voting_app/app/modules/hasil/components/liquid_script.dart';

import '../controllers/hasil_controller.dart';

class HasilView extends GetView<HasilController> {
  const HasilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HasilView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Progress...'),
            SizedBox(
              width: 400,
              height: 400,
              child: Obx(
                () => Echarts(
                  extensions: const [liquidScript],
                  // theme: 'dark',
                  option: '''
                                  {
                                    series: [{
                                        type: 'liquidFill',
                                        data: [${controller.valueLiquid.value}]
                                    }]
                                  }
                                ''',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
