import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrugViewScreen extends ConsumerWidget {
  const DrugViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Management'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
