import 'package:flutter/material.dart';

class ButtonDrugSubmit extends StatelessWidget {
  const ButtonDrugSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send),
      onPressed: () {},
      label: const Text('Send'),
    );
  }
}
