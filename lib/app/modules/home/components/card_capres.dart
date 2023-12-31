import 'package:flutter/material.dart';
import 'package:voting_app/app/core/colors/colors_app.dart';

import '../../../core/models/capres.dart';

class CardCapres extends StatelessWidget {
  const CardCapres({
    super.key,
    required this.data,
    this.onTap,
  });

  final CapresModel data;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorApp.white,
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              border: Border.all(color: ColorApp.primary),
            ),
            child: Column(
              children: [
                Row(
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
                Text('${data.stb}', style: const TextStyle(fontSize: 16)),
                Text('kelamin ${data.jkl}', style: const TextStyle(fontSize: 16)),
                Text('${data.prody}', style: const TextStyle(fontSize: 16)),
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
