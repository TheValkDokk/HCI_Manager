import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'App Locked',
                    style: TextStyle(fontSize: 50, color: Colors.blue),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.4),
                    child: SwipeableButtonView(
                      buttonText: 'SLIDE TO UNLOCK',
                      buttonWidget: const Hero(
                        tag: 'lockBtn',
                        child: Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                      ),
                      activeColor: Colors.white54,
                      indicatorColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
