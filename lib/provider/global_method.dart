import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/models/msg.dart';
import 'package:hci_manager/models/pharmacyUser.dart';
import 'package:hci_manager/provider/general_provider.dart';

import '../models/drug.dart';

void logout(WidgetRef ref) {
  FirebaseAuth.instance.signOut();
  ref.invalidate(googleSignInProvider);
}

Future submitToDB(Drug drug) async {
  final db = FirebaseFirestore.instance;
  db.collection('drugs').add(drug.toMap());
}

Future updateToDB(Drug drug) async {
  final update = drug.toMap();
  final db = FirebaseFirestore.instance
      .collection('drugs')
      .where('id', isEqualTo: drug.id)
      .get()
      .then(
    (value) {
      FirebaseFirestore.instance
          .collection('drugs')
          .doc(value.docs.first.id)
          .set(drug.toMap());
    },
  );
}

saveUser() async {
  String addr = '';
  String phone = '';
  String role = 'USER';
  final db = FirebaseFirestore.instance;
  try {
    final fUser = FirebaseAuth.instance.currentUser!;
    await db
        .collection('users')
        .where('mail', isEqualTo: fUser.email)
        .get()
        .then((value) {
      addr = value.docs.first.data()['addr'];
      phone = value.docs.first.data()['phone'];
      role = value.docs.first.data()['role'];
    });
    PharmacyUser user = PharmacyUser(
        mail: fUser.email,
        name: fUser.displayName,
        imgUrl: fUser.photoURL,
        role: role == 'USER' ? 'USER' : role,
        phone: phone == '' ? '' : phone,
        addr: addr == '' ? '' : addr);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.mail)
        .set(user.toMap());
    logging('Logging in', user);
  } catch (e) {}
}

Future logging(String text, PharmacyUser u) async {
  final db = FirebaseFirestore.instance;
  String msg = 'User ${u.name} $text at ${DateTime.now()}';
  Message msgSend = Message(user: u, time: DateTime.now(), msg: msg);
  await db.collection('log').add(msgSend.toMap());
}
