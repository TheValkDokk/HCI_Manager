import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/models/drug.dart';

import '../../components/side_menu.dart';
import '../../addons/responsive_layout.dart';
import 'components/add_drug.dart';
import 'components/drug_panel.dart';

final DrawerKeyProvider = StateProvider((_) => GlobalKey<ScaffoldState>());

class DrugViewScreen extends ConsumerStatefulWidget {
  const DrugViewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrugViewScreenState();
}

class _DrugViewScreenState extends ConsumerState<DrugViewScreen> {
  @override
  Widget build(BuildContext context) {
    final drawerKey = ref.watch(DrawerKeyProvider);
    double size = MediaQuery.of(context).size.width;
    double sizePhone = size * 0.7;
    double sizeTablet = size * 0.3;
    final dummy = dummyDrug;
    return NeumorphicApp(
      color: Colors.white,
      home: Scaffold(
        drawer: Responsive.isDesktop(context)
            ? null
            : SideMenu(Responsive.isTablet(context) ? sizeTablet : sizePhone),
        key: drawerKey,
        backgroundColor: Colors.white,
        endDrawer: Responsive.isDesktop(context) ? null : const AddDrug(),
        appBar: NeumorphicAppBar(
          title: const Text(
            'Drug Panel',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            !Responsive.isDesktop(context)
                ? NeumorphicButton(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20),
                      ),
                      color: Colors.white38,
                    ),
                    pressed: true,
                    onPressed: () => drawerKey.currentState!.openEndDrawer(),
                    child: Center(
                      child: NeumorphicIcon(
                        Icons.add_box_rounded,
                        size: 30,
                      ),
                    ),
                  )
                : Container(),
          ],
          centerTitle: true,
          leading: Responsive.isDesktop(context)
              ? null
              : NeumorphicButton(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(20),
                    ),
                    color: Colors.white38,
                  ),
                  pressed: true,
                  onPressed: () => drawerKey.currentState!.openDrawer(),
                  child: Center(
                    child: NeumorphicIcon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),
                ),
        ),
        body: LayoutBuilder(
          builder: (context, dimen) {
            if (Responsive.isDesktop(context)) {
              return Row(
                children: const [
                  Expanded(
                    flex: 3,
                    child: DrugPanel(),
                  ),
                  Expanded(
                    flex: 0,
                    child: AddDrug(),
                  ),
                ],
              );
            }
            if (Responsive.isTablet(context)) {
              return const DrugPanel();
            }
            if (Responsive.isMobile(context)) {}
            return const DrugPanel();
          },
        ),
      ),
    );
  }
}
