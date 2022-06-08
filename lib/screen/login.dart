import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../provider/general_provider.dart';
import '../provider/global_method.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gg = ref.watch(googleSignInProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.flutter_dash,
              color: Colors.blue,
              size: 200,
            ),
            const SizedBox(height: 50),
            const Text(
              'Pharmacy Store Management',
              style: TextStyle(fontSize: 30, color: Colors.green),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton.icon(
                onPressed: () {
                  signInWithGoogle(context, gg, ref);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.orange,
                ),
                label: const Text('Sign up with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signInWithGoogle(
      BuildContext context, GoogleSignIn gg, WidgetRef ref) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
        user = userCredential.user!;
        saveUser();
        navKey.currentState!.popUntil((route) => route.isFirst);
      } catch (e) {}
    } else {
      try {
        final ggSignIn = gg;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
        final GoogleSignInAccount? googleUser = await ggSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        saveUser();
        navKey.currentState!.popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
}
