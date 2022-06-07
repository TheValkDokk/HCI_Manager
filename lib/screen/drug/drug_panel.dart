import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/screen/drug/add_drug.dart';
import 'package:hci_manager/screen/order/drug_tile.dart';

import '../../models/drug.dart';

class DrugPanel extends StatelessWidget {
  const DrugPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('drugs').snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No Data or network connection',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Drug Added',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return Consumer(
              builder: (ctx, ref, _) {
                bool isDrawerOpen = ref.watch(isOpenAddDrugProvider);
                return GridView(
                  controller: ScrollController(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDrawerOpen ? 2 : 3,
                    childAspectRatio: isDrawerOpen ? 4 : 3,
                  ),
                  children: snapshot.data!.docs
                      .map((e) => DrugTile(
                          Drug.fromMap(e.data() as Map<String, dynamic>)))
                      .toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
