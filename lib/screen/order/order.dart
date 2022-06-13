import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hci_manager/components/side_menu.dart';
import 'package:hci_manager/screen/order/order_control.dart';
import 'package:hci_manager/screen/order/order_panel.dart';

import '../../addons/responsive_layout.dart';
import '../drug/drug_view.dart';

class OrderViewScreen extends StatefulWidget {
  const OrderViewScreen({Key? key}) : super(key: key);

  @override
  State<OrderViewScreen> createState() => _OrderViewScreenState();
}

class _OrderViewScreenState extends State<OrderViewScreen> {
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double sizePhone = size * 0.7;
    double sizeTablet = size * 0.3;
    return NeumorphicApp(
      home: Scaffold(
        drawer: Responsive.isDesktop(context)
            ? null
            : SideMenu(Responsive.isTablet(context) ? sizeTablet : sizePhone),
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
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      OrderSort1(),
                      SortBox(),
                    ],
                  ),
                  const SearchBox(),
                  const SizedBox(height: 20),
                  const Expanded(child: OrderPanel()),
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
              flex: 2,
              child: OrderControl(),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSort1 extends StatelessWidget {
  const OrderSort1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Filter by Status:   ',
          style: TextStyle(color: Colors.black),
        ),
        Container(
          width: 300,
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
              'Select Filter Value',
              style: TextStyle(color: Colors.black),
            ),
            onChanged: (v) {},
            items: const [
              DropdownMenuItem(
                value: 'up',
                child: Text('Done'),
              ),
              DropdownMenuItem(
                value: 'down',
                child: Text('Shipping'),
              ),
              DropdownMenuItem(
                value: 'down',
                child: Text('New '),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 500,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), border: Border.all()),
        child: const TextField(
          decoration: InputDecoration(
              hintText: 'Search', hintStyle: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class OrderSort extends StatelessWidget {
  const OrderSort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Sort by Name:   ',
          style: TextStyle(color: Colors.black),
        ),
        Container(
          width: 300,
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
