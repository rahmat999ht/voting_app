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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    width: 75,
                    height: 75,
                    child: Image.network(
                      "https://ui-avatars.com/api/?name=John+Doe",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
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
            Divider(),
            ListTile(
              title: Text('Visi:'),
              subtitle: Text('Apa aja', style: TextStyle(fontSize: 16)),
            ),
            Divider(),
            ListTile(
              title: Text('Misi:'),
              subtitle: Text('Apa aja', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
