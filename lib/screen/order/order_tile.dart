import 'dart:math';

import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.title, this.img, this.price, this.count, this.status);
  final String title;
  final String img;
  final String price;
  final int count;
  final status;

  @override
  Widget build(BuildContext context) {
    int d = Random().nextInt(10);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(img),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.blue),
            ),
            subtitle: Text(
              '$price - $count item',
              style: const TextStyle(color: Colors.black),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Status: $status',
                  style: const TextStyle(color: Colors.black),
                ),
                TextButton(onPressed: () {}, child: Text('Distric $d'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
