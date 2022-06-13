import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/drug.dart';

class OrderDurgTile extends ConsumerStatefulWidget {
  const OrderDurgTile(this.drug);

  final Drug drug;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDurgTileState();
}

class _OrderDurgTileState extends ConsumerState<OrderDurgTile> {
  var color = Colors.white;
  //return random number from range
  int ran = 1 + (Random().nextInt(10 - 1));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: ListTile(
            hoverColor: Colors.red,
            leading: Image.network(widget.drug.imgUrl, width: 100),
            title: Text(
              widget.drug.title,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Row(
              children: [
                Text(
                  widget.drug.price.toStringAsFixed(3),
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  '$ran count',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  'Container: ${widget.drug.container}',
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
