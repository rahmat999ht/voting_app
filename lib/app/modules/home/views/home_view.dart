import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:packages/extensions/size_app.dart';

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
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(
              child: Text(
                "Enter A Vote Code",
                style: TextStyle(fontSize: 20),
              ),
            ),
            20.sH,
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Entar code",
                border: OutlineInputBorder(),
              ),
            ),
            10.sH,
            ElevatedButton(onPressed: () {}, child: Text("Validate")),
            20.sH,
            Divider(
              color: Colors.grey[500],
            ),
            20.sH,
            const Text(
              "Nama nama capres didunia ini",
              style: TextStyle(fontSize: 20),
            ),
            20.sH,
            Material(
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
                              "https://ui-avatars.com/api/?name=John+Doe",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        10.sH,
                        Text(
                          "Nama pres , nomor urut",
                          style: TextStyle(fontSize: 20),
                        ),
                        10.sH,
                        Text("Apakah anda yakin memeilih ini?"),
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
                            "https://ui-avatars.com/api/?name=John+Doe",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nomor urut",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Nama capres",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
