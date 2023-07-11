import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/extensions/size_app.dart';

import '../components/indicator.dart';
import '../controllers/pemilihan_controller.dart';

class PemilihanView extends GetView<PemilihanController> {
  const PemilihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PemilihanView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Material(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      log("object");
                    },
                    child: SizedBox(
                      width: 130,
                      //height: 130,
                      child: Column(
                        children: [
                          12.sH,
                          const Text(
                            "No 1, Nama",
                            style: TextStyle(fontSize: 16),
                          ),
                          5.sH,
                          ClipOval(
                            child: Container(
                              color: Colors.grey[200],
                              child: Image.network(
                                "https://ui-avatars.com/api/?name=John+Doe",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          5.sH,
                          const Card(
                              color: Colors.yellow,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("15%"),
                              )),
                          12.sH,
                        ],
                      ),
                    ),
                  ),
                ),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data"),
                20.sW,
                const Text("data")
              ],
            ),
          ),
          Center(
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Obx(
                        () => PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  controller.touchedIndex.value = -1;
                                  return;
                                }
                                controller.touchedIndex.value = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Indicator(
                        color: Colors.blue,
                        text: 'First',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.yellow,
                        text: 'Second',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.purple,
                        text: 'Third',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.green,
                        text: 'Fourth',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
