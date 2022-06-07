import 'package:flutter/material.dart';

import '../../models/drug.dart';

class DrugTile extends StatelessWidget {
  const DrugTile(this.drug);

  final Drug drug;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: ListTile(
            leading: Image.network(drug.imgUrl),
            title: Text(
              drug.title,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Row(
              children: [
                Text(
                  drug.price.toStringAsFixed(3),
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  'Container: ${drug.container}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
