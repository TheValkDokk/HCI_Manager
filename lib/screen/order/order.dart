import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hci_manager/components/side_menu.dart';

import '../../addons/responsive_layout.dart';

class OrderViewScreen extends StatefulWidget {
  const OrderViewScreen({Key? key}) : super(key: key);

  @override
  State<OrderViewScreen> createState() => _OrderViewScreenState();
}

class _OrderViewScreenState extends State<OrderViewScreen> {
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      home: Scaffold(
        drawer: Responsive.isDesktop(context)
            ? null
            : SideMenu(MediaQuery.of(context).size.width * 0.3),
        key: key,
        backgroundColor: Colors.white,
        appBar: NeumorphicAppBar(
          title: const Text(
            'Orders',
            style: TextStyle(color: Colors.grey),
          ),
          centerTitle: true,
          leading: Responsive.isTablet(context)
              ? NeumorphicButton(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20)),
                      color: Colors.white38),
                  onPressed: () => key.currentState!.openDrawer(),
                  child: Center(
                    child: NeumorphicIcon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),
                )
              : null,
        ),
        body: const Center(
          child: Text('Order View'),
        ),
      ),
    );
  }
}
