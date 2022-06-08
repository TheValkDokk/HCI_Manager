import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hci_manager/components/side_menu.dart';
import 'package:hci_manager/models/pharmacyUser.dart';

final googleSignInProvider = StateProvider((_) => GoogleSignIn());

final ScreenProvider = StateProvider((_) => MenuItems.drug);

final userProvider = StateProvider((_) => dummyUser);
