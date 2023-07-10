import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:packages/extensions/size_app.dart';
import 'package:packages/forms/form.dart';

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
            Center(
              child: const Text(
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
            10.sH,
          ],
        ));
  }
}
