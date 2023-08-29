// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/state/loading.dart';
import 'package:voting_app/app/core/interface/app_bar/app_bar_title.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/modules/pemilihan/components/detail_capres.dart';

import '../../../core/models/pemilih_capres.dart';
import '../components/card_capres.dart';
import '../components/card_statictik.dart';
import '../components/indicator.dart';
import '../controllers/pemilihan_controller.dart';

class PemilihanView extends GetView<PemilihanController> {
  const PemilihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(
        title: 'Hasil Sementara',
      ),
      body: controller.obx(
        (state) {
          return controller.controllerHome.obx(
            (stateHome) {
              final totalPemilih =
                  controller.controllerPemilih.listPemilihAktif.length;
              final listPemilihCapres = <PemilihCapresModel>[];
              for (int index = 0; index < stateHome!.length; index++) {
                final dataPemilihanCapres = state!
                    .where((e) => e.capres!.id == stateHome[index].id)
                    .toList();
                final persen =
                    (dataPemilihanCapres.length / totalPemilih) * 100;
                final stringPersen = '${persen.toStringAsFixed(2)}%';
                log('dataPemilihanCapres $dataPemilihanCapres');
                log('listPemilihCapres $listPemilihCapres');
                listPemilihCapres.add(
                  PemilihCapresModel(
                    noUrut: stateHome[index].noUrut!,
                    bykPemilih: dataPemilihanCapres.length.toDouble(),
                    persen: stringPersen,
                  ),
                );
              }
              listPemilihCapres.sort(
                (a, b) => a.noUrut.compareTo(b.noUrut),
              );
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            ...List.generate(
                              stateHome.length,
                              (index) => CardCapresPV(
                                data: stateHome[index],
                                colors: controller.listColors[index],
                                persen: listPemilihCapres[index].persen,
                                onTap: () {
                                  Get.to(
                                    DetailCapres(data: stateHome[index]),
                                  );
                                },
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    CardStatistik(
                      dataSemuaPemilihan: state!,
                      dataSemuaCapres: stateHome,
                      listColor: controller.listColors,
                    ),
                    listIndokator(stateHome),
                  ],
                ),
              );
            },
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
