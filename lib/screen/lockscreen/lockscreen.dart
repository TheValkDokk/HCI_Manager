import 'dart:ui';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/addons/responsive_layout.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isFinished = false;
  final double _sigmaX = 10.0;
  final double _sigmaY = 10.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.flutter_dash,
                      color: Colors.blue,
                      size: 300,
                    ),
                    const Text(
                      'App Locked',
                      style: TextStyle(fontSize: 50, color: Colors.blue),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isMobile(context)
                              ? size * 0.1
                              : Responsive.isTablet(context)
                                  ? size * 0.3
                                  : size * 0.4),
                      child: Consumer(
                        builder: (context, ref, child) => SwipeableButtonView(
                          buttonText: 'SLIDE TO UNLOCK',
                          buttonWidget: const Hero(
                            tag: 'lockBtn',
                            child: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                          ),
                          activeColor: Colors.blue,
                          indicatorColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                          isFinished: isFinished,
                          onWaitingProcess: () {
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                isFinished = true;
                              });
                            });
                          },
                          onFinish: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
