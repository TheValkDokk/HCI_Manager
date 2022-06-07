import 'package:flutter/material.dart';

import '../addons/breakpoint.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: kBadgeColor, borderRadius: BorderRadius.circular(9)),
      child: Text(
        count.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
