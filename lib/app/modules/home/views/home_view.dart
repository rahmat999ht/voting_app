import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:packages/packages.dart';
import 'package:voting_app/app/core/colors/colors_app.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilih.dart';
import 'package:voting_app/app/core/models/waktu_pemilihan.dart';

import '../../../core/interface/app_bar/app_bar_title.dart';
import '../components/card_capres.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(
        title: 'Home',
      ),
      body: controller.contDas.obx(
        (state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Form(
              key: controller.formKeyValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.contPem.obx(
                    (stCP) {
                      final stateAktif =
                          stCP!.where((e) => e.isAktif == true).toList();
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (stateAktif.isEmpty) pemilihanTertutup(),
                            if (stateAktif.isNotEmpty)
                              if (state is PemilihModel)
                                if (state.isMemilih == false)
                                  infoBelumMemilih()
                                else
                                  infoSudahMemilih(),
                            if (stateAktif.isNotEmpty)
                              if (state is PemilihModel)
                                if (state.isMemilih! == true)
                                  controller.obx(
                                    (st) => Expanded(
                                      child: listCapresJikaSudahMemilih(
                                        stateAktif,
                                        st,
                                        state,
                                      ),
                                    ),
                                    onEmpty: const EmptyState(),
                                    onLoading: const LoadingState(),
                                    onError: (e) =>
                                        ErrorState(error: e.toString()),
                                  )
                                else
                                  controller.obx(
                                    (st) => Expanded(
                                      child: listCapresJikaBelumMemilih(
                                        stateAktif,
                                        st,
                                        state,
                                      ),
                                    ),
                                    onEmpty: const EmptyState(),
                                    onLoading: const LoadingState(),
                                    onError: (e) =>
                                        ErrorState(error: e.toString()),
                                  ),
                          ],
                        ),
                      );
                    },
                    onEmpty: const EmptyState(),
                    onLoading: const LoadingState(),
                    onError: (e) => ErrorState(error: e.toString()),
                  ),
                ],
              ),
            ),
          );
        },
        onEmpty: const EmptyState(),
        onLoading: const LoadingState(),
        onError: (e) => ErrorState(error: e.toString()),
      ),
    );
  }

  Column listCapresJikaBelumMemilih(List<WaktuPemModel> stateAktif,
      List<CapresModel>? st, PemilihModel state) {
    return Column(
      children: [
        Text(
          "Capres Bem periode : ${stateAktif.first.periode}",
          style: const TextStyle(fontSize: 16),
        ),
        12.sH,
        Divider(
          color: Colors.grey[500],
        ),
        12.sH,
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              ...List.generate(
                st!.length,
                (index) => CardCapres(
                  data: st[index],
                  onTap: () => alertMemilih(
                    data: st[index],
                    isMemilih: state.isMemilih!,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Column listCapresJikaSudahMemilih(List<WaktuPemModel> stateAktif,
      List<CapresModel>? st, PemilihModel state) {
    return Column(
      children: [
        Text(
          "Capres Bem periode : ${stateAktif.first.periode}",
          style: const TextStyle(fontSize: 16),
        ),
        12.sH,
        Divider(
          color: Colors.grey[500],
        ),
        12.sH,
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              ...List.generate(
                st!.length,
                (index) => CardCapres(
                  data: st[index],
                  onTap: () => alertMemilih(
                    data: st[index],
                    isMemilih: state.isMemilih!,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Column infoSudahMemilih() {
    return Column(
      children: [
        const Text(
          "Anda sudah malakukan pemilihan",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        8.sH,
        const Text(
          "Anda sudah tidak bisa melakukan pemilihan Capres Bem",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        20.sH,
        Divider(
          color: Colors.grey[500],
        ),
        12.sH,
      ],
    );
  }

  Column infoBelumMemilih() {
    return Column(
      children: [
        const Text(
          "Anda belum malakukan pemilihan",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
        ),
        8.sH,
        const Text(
          "Silahkan memilih Capres Bem pilihan Anda",
          style: TextStyle(fontSize: 16),
        ),
        20.sH,
        Divider(
          color: Colors.grey[500],
        ),
        12.sH,
      ],
    );
  }

  Column pemilihanTertutup() {
    return Column(
      children: [
        const Text(
          "Pemilihan presiden BEM belum terbuka",
          style: TextStyle(fontSize: 16),
        ),
        12.sH,
        Divider(
          color: Colors.grey[500],
        ),
        12.sH,
        const Center(
          child: Text(
            "Calon presiden belum ada karena pemilihan belum terbuka, silahkan tunggu periode selanjutnya",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        20.sH,
        Divider(
          color: Colors.grey[500],
        ),
        100.sH,
        Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
                side: BorderSide(color: ColorApp.primary)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                LineIcons.userEdit,
                size: 180,
                color: ColorApp.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> alertMemilih({
    required CapresModel data,
    required bool isMemilih,
  }) {
    return Get.defaultDialog(
      title: "Info",
      content: Obx(
        () => Stack(
          children: [
            if (controller.isLoadingMemilih.isTrue)
              Container(
                height: 100,
                width: Get.width,
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (controller.isLoadingMemilih.isFalse)
              if (isMemilih == true)
                const Text("Anda telah melakukan pemilihan")
              else
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 75,
                        height: 75,
                        color: Colors.grey[200],
                        child: Image.network(
                          data.foto!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    10.sH,
                    Text(
                      "${data.noUrut} , ${data.nama}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    10.sH,
                    const Text("Apakah anda yakin memilih ini?"),
                  ],
                ),
          ],
        ),
      ),
      onConfirm: () {
        if (isMemilih == true) {
          Get.back();
        } else {
          controller.memilih(idCapres: data.id!);
        }
      },
      onCancel: () => Get.back(),
      buttonColor: ColorApp.primary,
      confirmTextColor: ColorApp.black,
      cancelTextColor: ColorApp.black,
    );
  }
}
  // const Center(
              //   child: Text(
              //     "Enter A Vote Code",
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),
              // 20.sH,
              // TextForm.border(
              //   controller: controller.cValidate,
              //   title: 'Entar code',
              //   isCheck: true,
              // ),
              // 10.sH,
              // Obx(
              //   () => ButtonPrymary(
              //     isLoading: controller.isLoadingValidate.value,
              //     onPressed: controller.validate,
              //     text: "Validate",
              //   ),
              // ),
              // 12.sH,
              // Divider(
              //   color: Colors.grey[500],
              // ),
