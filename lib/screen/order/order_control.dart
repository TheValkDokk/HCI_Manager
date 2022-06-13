// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../models/drug.dart';
import 'drug_order_tile.dart';

class OrderControl extends StatelessWidget {
  const OrderControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('drugs');
    Future<List<Drug>> getListDrug() async {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('drugs').limit(10).get();
      return snapshot.docs.map((e) {
        return Drug.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    }

    List<Drug> list = [];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Cao Chanh Duc',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          const Text(
            'Address: 123 ABC District ABC, TP.HCM',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          const Text(
            'Date: June 15, 2022',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Price: 500,000',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                '5 Items',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                'Status: New',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                int count = 0;
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.sublist(0, 5).map((e) {
                    return AnimationConfiguration.staggeredList(
                      position: count++,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: OrderDurgTile(
                              Drug.fromMap(e.data() as Map<String, dynamic>)),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
            stream: db.snapshots(),
          ),
          //3 ElevatedButton in a row with 3 different colors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
                width: 150,
                child: RaisedButton(
                  color: Colors.red,
                  shape: const StadiumBorder(),
                  onPressed: () {},
                  child: const Text(
                    'Accpect Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                width: 150,
                child: RaisedButton(
                  color: Colors.green,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Parcel Ready',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 70,
                width: 150,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Parvel Shipped',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
