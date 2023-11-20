import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/packages.dart';
import 'package:voting_app/app/core/interface/alerts/alert_info.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilih.dart';

import '../../../core/colors/colors_app.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.dashboardC.obx(
      (state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: ColorApp.white.withOpacity(0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profil', style: TextStyle(color: ColorApp.black)),
              if (state is PemilihModel)
                if (state.isAktif == true)
                  ButtonPrymary(
                    onPressed: () {
                      // alertInfo(
                      //   'info',
                      //   'akun anda di non-aktifkan oleh admin, anda tidak bisa melakukan pemilihan dan jika sudah melakukan pemilihan, suara anda tidak akan terhitung kedalam rekapan pemilihan',
                      // );
                      alertInfo(
                        'info',
                        'akun anda berstatus aktif, anda bisa melakukan pemilihan dan suara anda akan terhitung kedalam rekapan pemilihan',
                      );
                    },
                    text: "Aktif",
                    textColor: ColorApp.black,
                    bgColor: ColorApp.primary,
                    width: 100,
                  )
                else
                  ButtonPrymary(
                    onPressed: () {
                      alertInfo(
                        'info',
                        'akun anda di non-aktifkan oleh admin, anda tidak bisa melakukan pemilihan dan jika sudah melakukan pemilihan, suara anda tidak akan terhitung kedalam rekapan pemilihan',
                      );
                    },
                    text: "Non Aktif",
                    textColor: ColorApp.black,
                    bgColor: ColorApp.red,
                    width: 100,
                  ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (state is PemilihModel)
                Column(
                  children: [
                    40.sH,
                    ListTile(
                      title: const Text('Nama :'),
                      subtitle: Text('${state.nama}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('STB :'),
                      subtitle: Text('${state.stb}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    const Divider(),
                    if (state.isMemilih == true)
                      const ListTile(
                        title: Text('Status Memilih:'),
                        subtitle: Text('Sudah', style: TextStyle(fontSize: 16)),
                      )
                    else
                      const ListTile(
                        title: Text('Status Memilih:'),
                        subtitle: Text('Belum Memilih',
                            style: TextStyle(fontSize: 16)),
                      ),
                  ],
                ),
              if (state is CapresModel)
                Column(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 75,
                        height: 75,
                        child: Image.network(
                          "${state.foto}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Nama :'),
                      subtitle: Text('${state.nama}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('STB :'),
                      subtitle: Text('${state.stb}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Jenis kelamin :'),
                      subtitle: Text('${state.jkl}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Jurusan :'),
                      subtitle: Text('${state.prody}',
                          style: const TextStyle(fontSize: 16)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Visi:'),
                      subtitle: Column(
                        children:
                            state.visi!.map((e) => carsVisiMisi(e)).toList(),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Misi:'),
                      subtitle: Column(
                        children:
                            state.misi!.map((e) => carsVisiMisi(e)).toList(),
                      ),
                    ),
                  ],
                ),
              ButtonPrymary(
                onPressed: controller.logOut,
                text: "Logout",
                textColor: ColorApp.black,
                bgColor: ColorApp.primary,
                width: 100,
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: TextButton(
        //   onPressed: () {},
        //   child: const Text("Logout"),
        // ),
      ),
      onEmpty: const Center(child: Text("Masih Kosong")),
      onLoading: const LoadingState(),
      onError: (e) {
        return Center(child: Text("pesan error : $e"));
      },
    );
  }

  Padding carsVisiMisi(e) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 12,
            color: Colors.blue,
          ),
          Text(' $e'),
        ],
      ),
    );
  }
}
