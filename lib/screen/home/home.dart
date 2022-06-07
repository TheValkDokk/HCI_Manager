import 'package:concentric_transition/page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/components/side_menu.dart';
import 'package:hci_manager/responsive_layout.dart';
import 'package:hci_manager/screen/drug/drug_view.dart';
import 'package:hci_manager/screen/prescription/prescription.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../provider/general_provider.dart';
import '../lockscreen/lockscreen.dart';
import '../order/order.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int duration = 500;
  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 15),
        invalidateSessionForUserInactiviity: const Duration(minutes: 5));
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
          return const LockScreen();
        }));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
          return const LockScreen();
        }));
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: Responsive(
        MobileView(AnimatedSwitcher(
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          duration: Duration(milliseconds: duration),
          child: getScreen(),
        )),
        TabletView(AnimatedSwitcher(
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          duration: Duration(milliseconds: duration),
          child: getScreen(),
        )),
        WebView(AnimatedSwitcher(
          duration: Duration(milliseconds: duration),
          child: getScreen(),
        )),
      ),
    );
  }

  Widget getScreen() {
    final currentScreen = ref.watch(ScreenProvider);
    switch (currentScreen) {
      case MenuItems.drug:
        return const DrugViewScreen(key: Key('DrugView'));
      case MenuItems.orders:
        return const OrderViewScreen(key: Key('OrderView'));
      case MenuItems.prescrip:
        return const PrescriptionViewScreen(key: Key('PresView'));
      default:
        return const DrugViewScreen(key: Key('DrugView'));
    }
  }
}

class WebView extends StatelessWidget {
  const WebView(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: SideMenu(0)),
        Expanded(flex: 8, child: child),
      ],
    );
  }
}

class TabletView extends StatelessWidget {
  const TabletView(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
      ],
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
      ],
    );
  }
}
