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
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SortDateBox(),
                            SortBox(),
                          ],
                        ),
                        const Expanded(child: DrugPanel()),
                        SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: const Text(
                                  '1',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const Text(
                                '2',
                                style: TextStyle(color: Colors.black),
                              ),
                              const Text(
                                '3',
                                style: TextStyle(color: Colors.black),
                              ),
                              const Text(
                                '4',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  ),
                  const Expanded(
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

class SortDateBox extends StatelessWidget {
  const SortDateBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Sort by Date:   ',
          style: TextStyle(color: Colors.black),
        ),
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all()),
          child: DropdownButton(
            dropdownColor: Colors.white,
            isExpanded: true,
            style: const TextStyle(color: Colors.black),
            hint: const Text(
              'Sort',
              style: TextStyle(color: Colors.black),
            ),
            onChanged: (v) {},
            items: const [
              DropdownMenuItem(
                value: 'up',
                child: Text('Ascending'),
              ),
              DropdownMenuItem(
                value: 'down',
                child: Text('Descending '),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SortBox extends StatelessWidget {
  const SortBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Sort by Name:   ',
          style: TextStyle(color: Colors.black),
        ),
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(25),
              border: Border.all()),
          child: DropdownButton(
            dropdownColor: Colors.white,
            isExpanded: true,
            style: const TextStyle(color: Colors.black),
            hint: const Text(
              'Sort',
              style: TextStyle(color: Colors.black),
            ),
            onChanged: (v) {},
            items: const [
              DropdownMenuItem(
                value: 'up',
                child: Text('Ascending'),
              ),
              DropdownMenuItem(
                value: 'down',
                child: Text('Descending'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
