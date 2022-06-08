import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../components/side_menu.dart';
import '../../addons/responsive_layout.dart';

class PrescriptionViewScreen extends StatefulWidget {
  const PrescriptionViewScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionViewScreen> createState() => _PrescriptionViewScreenState();
}

class _PrescriptionViewScreenState extends State<PrescriptionViewScreen> {
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
            'Prescription',
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
          child: Text('Prescription View'),
        ),
      ),
    );
  }
}
