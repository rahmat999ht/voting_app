import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';
import 'package:voting_app/app/core/models/capres.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Enter A Vote Code",
                style: TextStyle(fontSize: 20),
              ),
            ),
            20.sH,
            const TextField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Entar code",
                border: OutlineInputBorder(),
              ),
            ),
            10.sH,
            ElevatedButton(onPressed: () {}, child: const Text("Validate")),
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
    );
  }
}

class CardCapres extends StatelessWidget {
  const CardCapres({
    super.key,
    required this.data,
  });

  final CapresModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "Info",
              content: Column(
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
              onConfirm: () {},
              onCancel: () => Get.back(),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    width: 75,
                    height: 75,
                    color: Colors.grey[200],
                    child: Image.network(
                      '${data.foto}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No. ${data.noUrut}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${data.nama}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
