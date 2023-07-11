import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:get/get.dart';
import 'package:packages/extensions/size_app.dart';
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
      body: HasilAkhir(controller: controller),
    );
  }
}

class HasilAkhir extends StatelessWidget {
  const HasilAkhir({super.key, required this.controller});
  final HasilController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            print("object");
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            //height: 130,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                12.sH,
                Text(
                  "Selamat kepada yang terpilih",
                  style: TextStyle(fontSize: 24),
                ),
                12.sH,
                Text(
                  "No 1, Nama",
                  style: TextStyle(fontSize: 20),
                ),
                12.sH,
                ClipOval(
                  child: Container(
                    height: 160,
                    width: 160,
                    color: Colors.grey[200],
                    child: Image.network(
                      "https://ui-avatars.com/api/?name=John+Doe",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                12.sH,
                Text(
                  "Dengan total suara 90% ",
                  style: TextStyle(fontSize: 20),
                ),
                12.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HasilSementara extends StatelessWidget {
  const HasilSementara({
    super.key,
    required this.controller,
  });

  final HasilController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
