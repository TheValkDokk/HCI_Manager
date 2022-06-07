import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/responsive_layout.dart';
import 'package:hci_manager/screen/drug/add_drug.dart';
import 'package:hci_manager/screen/order/drug_tile.dart';

import '../../models/drug.dart';

final drugLoadProvider = StateProvider(((ref) => dummyDrug));

class DrugPanel extends StatelessWidget {
  const DrugPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('drugs').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (!snapshot.hasData) {
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
                int crossAxi = isDrawerOpen
                    ? Responsive.isMobile(context)
                        ? 1
                        : 2
                    : 3;
                double childAspect = isDrawerOpen ? 4 : 4;
                return GridView(
                  controller: ScrollController(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxi,
                    childAspectRatio: childAspect,
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
