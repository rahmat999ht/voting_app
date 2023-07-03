import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: const Center(
        child: Text(
          'PemilihanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
