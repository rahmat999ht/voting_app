// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/extensions/size_app.dart';
import 'package:packages/state/loading.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilihan.dart';
import 'package:voting_app/app/modules/pemilihan/controllers/pemilih_controller.dart';

import '../../../core/models/pemilih_capres.dart';
import '../components/indicator.dart';
import '../controllers/pemilihan_controller.dart';

class PemilihanView extends GetView<PemilihanController> {
  const PemilihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemilihan'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) {
          final totalPemilih =
              controller.controllerPemilih.listPemilihModel.length;
          final dataSemuaPemilihan = state!;
          final capres01 = dataSemuaPemilihan
              .where((e) => e.capres!.id == 'h7vlv6B98ZcQCU7jE6Uw')
              .toList();
          final capres02 = dataSemuaPemilihan
              .where((e) => e.capres!.id == 'P3KfoNxdvtFqUwbR9urP')
              .toList();
          final capres03 = dataSemuaPemilihan
              .where((e) => e.capres!.id == 'pk3QADckQZfpBLZsSG3L')
              .toList();
          final pemilihCapres01 = (capres01.length / totalPemilih) * 100;
          final pemilihCapres02 = (capres02.length / totalPemilih) * 100;
          final pemilihCapres03 = (capres03.length / totalPemilih) * 100;
          final persenCapres01 = '${pemilihCapres01.toStringAsFixed(2)}%';
          final persenCapres02 = '${pemilihCapres02.toStringAsFixed(2)}%';
          final persenCapres03 = '${pemilihCapres03.toStringAsFixed(2)}%';
          final listPersen = [
            persenCapres01,
            persenCapres02,
            persenCapres03,
          ];
          return controller.controllerHome.obx(
            (stateHome) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          ...List.generate(
                            stateHome!.length,
                            (index) => CardCapresPV(
                              data: stateHome[index],
                              colors: controller.listColors[index],
                              persen: listPersen[index],
                              onTap: () {
                                log('object Capres');
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  CardStatistik(
                    dataSemuaPemilihan: state,
                    dataSemuaCapres: stateHome,
                    listColor: controller.listColors,
                  ),
                  listIndokator(stateHome),
                ],
              ),
            ),
            onEmpty: const Center(child: Text("Masih Kosong")),
            onLoading: const LoadingState(),
            onError: (e) {
              return Center(child: Text("pesan error : $e"));
            },
          );
        },
        onEmpty: const Center(child: Text("Masih Kosong")),
        onLoading: const LoadingState(),
        onError: (e) {
          return Center(child: Text("pesan error : $e"));
        },
      ),
    );
  }

  Column listIndokator(List<CapresModel> stateHome) {
    return Column(
      children: [
        ...stateHome.mapIndexed((i, e) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20,
            ),
            child: Indicator(
              color: controller.listColors[i],
              text: e.nama!,
              isSquare: true,
            ),
          );
        }).toList(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20,
          ),
          child: Indicator(
            color: controller.listColors[stateHome.length],
            text: 'Belum Memilih',
            isSquare: true,
          ),
        ),
      ],
    );
  }
}

class CardStatistik extends GetView<PemilihController> {
  const CardStatistik({
    super.key,
    required this.dataSemuaPemilihan,
    required this.dataSemuaCapres,
    required this.listColor,
  });

  final List<PemilihanModel> dataSemuaPemilihan;
  final List<CapresModel> dataSemuaCapres;
  final List<Color> listColor;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => SizedBox(
        width: Get.width,
        height: 250,
        child: Center(
          child: Obx(
            () => PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      controller.touchedIndex.value = -1;
                      return;
                    }
                    controller.touchedIndex.value =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                startDegreeOffset: -25,
                centerSpaceRadius: 50,
                sections: showingSections(state!.length),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(int totalPemilih) {
    return List.generate(dataSemuaCapres.length + 1, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final listPemilihCapres = <PemilihCapresModel>[];
      for (int index = 0; index < dataSemuaCapres.length; index++) {
        final dataPemilihanCapres = dataSemuaPemilihan
            .where((e) => e.capres!.id == dataSemuaCapres[index].id)
            .toList();
        final persen = (dataPemilihanCapres.length / totalPemilih) * 100;
        final stringPersen = '${persen.toStringAsFixed(2)}%';
        log('dataPemilihanCapres $dataPemilihanCapres');
        log('listPemilihCapres $listPemilihCapres');
        listPemilihCapres.add(
          PemilihCapresModel(
            noUrut: dataSemuaCapres[index].noUrut!,
            bykPemilih: dataPemilihanCapres.length.toDouble(),
            persen: stringPersen,
          ),
        );
      }
      listPemilihCapres.sort(
        (a, b) => a.noUrut.compareTo(b.noUrut),
      );
      final belumMemilih =
          (controller.listBelumMemilih.length / totalPemilih) * 100;
      final persenanBelumMemilih = '${belumMemilih.toStringAsFixed(2)}%';

      listPemilihCapres.add(
        PemilihCapresModel(
          noUrut: 'Belum Memilih',
          bykPemilih: belumMemilih,
          persen: persenanBelumMemilih,
        ),
      );
      return PieChartSectionData(
        color: listColor[i],
        value: listPemilihCapres[i].bykPemilih,
        title: listPemilihCapres[i].persen,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
      );
    });
  }
}

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
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        width: 130,
        height: 225,
        child: Column(
          children: [
            12.sH,
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
              color: colors,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(persen ?? '0%'),
              ),
            ),
            12.sH,
          ],
        ),
      ),
    );
  }
}
