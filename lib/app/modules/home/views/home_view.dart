import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';
import 'package:voting_app/app/core/models/capres.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Form(
          key: controller.formKeyValidate,
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Enter A Vote Code",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              20.sH,
              TextForm.border(
                controller: controller.cValidate,
                title: 'Entar code',
                isCheck: true,
              ),
              10.sH,
              Obx(
                () => ButtonPrymary(
                  isLoading: controller.isLoadingValidate.value,
                  onPressed: controller.validate,
                  text: "Validate",
                ),
              ),
              12.sH,
              Divider(
                color: Colors.grey[500],
              ),
              12.sH,
              const Text(
                "Nama nama capres didunia ini",
                style: TextStyle(fontSize: 20),
              ),
              20.sH,
              controller.obx(
                (state) => Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ...List.generate(
                        state!.length,
                        (index) => CardCapres(
                          data: state[index],
                          onTap: () => alertMemilih(state[index]),
                        ),
                      ),
                    ]),
                  ),
                ),
                onEmpty: const Center(child: Text("Masih Kosong")),
                onLoading: const SizedBox(height: 130, child: LoadingState()),
                onError: (e) {
                  return Center(child: Text("pesan error : $e"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> alertMemilih(CapresModel data) {
    return Get.defaultDialog(
      title: "Info",
      content: Obx(
        () => Stack(
          children: [
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
                const Text("Apakah anda yakin memeilih ini?"),
              ],
            ),
            if (controller.isLoadingMemilih.isTrue)
              Container(
                height: Get.height,
                width: Get.width,
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
      onConfirm: controller.memilih,
      onCancel: () => Get.back(),
    );
  }
}
