import 'package:flutter/material.dart';

import '../../../core/interface/app_bar/app_bar_back.dart';
import '../../../core/models/capres.dart';

class DetailCapres extends StatelessWidget {
  const DetailCapres({super.key, required this.data});

  final CapresModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(title: 'Detail Biodata Capres'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.network(
                    "${data.foto}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Nama :'),
                subtitle:
                    Text('${data.nama}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('STB :'),
                subtitle:
                    Text('${data.stb}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('Jenis kelamin :'),
                subtitle:
                    Text('${data.jkl}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('Jurusan :'),
                subtitle:
                    Text('${data.prody}', style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
              ListTile(
                title: const Text('Visi:'),
                subtitle: Column(
                  children: data.visi!.map((e) => carsVisiMisi(e)).toList(),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Misi:'),
                subtitle: Column(
                  children: data.misi!.map((e) => carsVisiMisi(e)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
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
