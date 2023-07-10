import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:packages/extensions/size_app.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ProfileView'),
            const Text('Aktif'),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListTile(
                title: Text('Nama :'),
                subtitle: Text('Miming', style: TextStyle(fontSize: 16)),
              ),
              Divider(),
              ListTile(
                title: Text('STB :'),
                subtitle: Text('192567', style: TextStyle(fontSize: 16)),
              ),
              Divider(),
              ListTile(
                title: Text('Jenis kelamin :'),
                subtitle: Text('Laki laki', style: TextStyle(fontSize: 16)),
              ),
              Divider(),
              ListTile(
                title: Text('Jurusan :'),
                subtitle: Text('Tata boga', style: TextStyle(fontSize: 16)),
              ),
              Divider(),
              ListTile(
                title: Text('Status Memilih:'),
                subtitle: Text('Sudah', style: TextStyle(fontSize: 16)),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
