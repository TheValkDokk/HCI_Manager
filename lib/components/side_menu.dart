import 'package:concentric_transition/page_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hci_manager/screen/drug/components/drug_panel.dart';
import 'package:hci_manager/screen/drug/drug_view.dart';
import 'package:hci_manager/screen/lockscreen/lockscreen.dart';
import '../addons/breakpoint.dart';
import '../provider/general_provider.dart';
import '../provider/global_method.dart';
import '../addons/responsive_layout.dart';
import '../screen/drug/components/add_drug.dart';
import 'side_menu_item.dart';

class MenuItemDra {
  final String title;
  final IconData icon;
  const MenuItemDra(this.title, this.icon);
}

class MenuItems {
  static const drug = MenuItemDra('Drugs', FontAwesomeIcons.capsules);
  static const orders = MenuItemDra('Orders', FontAwesomeIcons.bagShopping);
  static const transfer =
      MenuItemDra('Transfer', FontAwesomeIcons.arrowRightArrowLeft);
  static const prescrip =
      MenuItemDra('Prescription', FontAwesomeIcons.prescriptionBottle);

  static const all = <MenuItemDra>[drug, orders, prescrip, transfer];
}

class SideMenu extends StatelessWidget {
  const SideMenu(this.widthSize);

  final double widthSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final u = FirebaseAuth.instance.currentUser!;
    final imgSize = size.width * 0.5;
    return Material(
      child: Container(
        width: widthSize == 0 ? double.infinity : widthSize,
        height: double.infinity,
        padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgLightColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Consumer(builder: (context, ref, child) {
              if (Responsive.isTablet(context)) {
                return SingleChildScrollView(
                  child: mainView(context, u, imgSize, size, ref),
                );
              } else {
                return mainView(context, u, imgSize, size, ref);
              }
            }),
          ),
        ),
      ),
    );
  }

  Column mainView(
      BuildContext context, User u, double imgSize, Size size, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Responsive.isTablet(context) ? 50 : 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.network(
                  u.photoURL.toString(),
                  width: Responsive.isMobile(context)
                      ? imgSize
                      : Responsive.isTablet(context)
                          ? size.width * 0.1
                          : size.width * 0.2,
                  height: Responsive.isMobile(context)
                      ? imgSize
                      : Responsive.isTablet(context)
                          ? size.width * 0.1
                          : size.width * 0.2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (Responsive.isDesktop(context)) const Spacer(),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    // if (!Responsive.isDesktop(context))
                    //   const CloseButton(),

                    Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      u.displayName.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
        if (!Responsive.isDesktop(context))
          Text(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            u.displayName.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: kDefaultPadding),
        addSearchBtnGroup(context, ref),
        if (!Responsive.isTablet(context)) const Spacer(),
        // SideMenuItem(
        //   press: () => ref.read(ScreenProvider.notifier).state = MenuItems.drug,
        //   title: "Drugs",
        //   icon: MenuItems.drug.icon,
        //   isActive: ref.watch(ScreenProvider) == MenuItems.drug,
        //   itemCount: 3,
        // ),
        // SideMenuItem(
        //   press: () {
        //     ref.read(ScreenProvider.notifier).state = MenuItems.orders;
        //   },
        //   title: "Orders",
        //   icon: MenuItems.orders.icon,
        //   isActive: ref.watch(ScreenProvider) == MenuItems.orders,
        //   itemCount: 0,
        // ),
        // SideMenuItem(
        //   press: () =>
        //       ref.read(ScreenProvider.notifier).state = MenuItems.prescrip,
        //   title: "Prescriptions",
        //   icon: MenuItems.prescrip.icon,
        //   isActive: ref.watch(ScreenProvider) == MenuItems.prescrip,
        //   itemCount: 0,
        // ),
        // SideMenuItem(
        //   press: () =>
        //       ref.read(ScreenProvider.notifier).state = MenuItems.prescrip,
        //   title: "Transfer Drug",
        //   icon: MenuItems.transfer.icon,
        //   isActive: ref.watch(ScreenProvider) == MenuItems.prescrip,
        //   itemCount: 0,
        // ),
        ...MenuItems.all.map(groupMenu).toList(),
        if (!Responsive.isTablet(context)) const Spacer(),
        SideMenuItem(
          press: () {
            if (Responsive.isDesktop(context)) {
              Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
                return const LockScreen();
              }));
            } else {
              ref
                  .read(DrawerKeyProvider.notifier)
                  .state
                  .currentState!
                  .closeDrawer();
              Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
                return const LockScreen();
              }));
            }
          },
          title: "Lock",
          icon: Icons.lock,
          isActive: true,
          itemCount: 0,
        ),
        Consumer(
          builder: (ctx, ref, _) => SideMenuItem(
            press: () => logout(ref),
            title: "Logout",
            icon: Icons.logout,
            isActive: true,
            itemCount: 0,
          ),
        ),
      ],
    );
  }

  Widget groupMenu(MenuItemDra item) {
    return Consumer(
      builder: (context, ref, child) => SideMenuItem(
        press: () => ref.read(ScreenProvider.notifier).state = item,
        title: item.title,
        icon: item.icon,
        isActive: ref.watch(ScreenProvider) == item,
        itemCount: 0,
      ),
    );
  }

  Widget addSearchBtnGroup(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        NeumorphicButton(
          style: NeumorphicStyle(
              intensity: 5,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: const Color(0xFF0087F9)),
          onPressed: () {
            if (Responsive.isDesktop(context)) {
              ref.read(ScreenProvider.notifier).state = MenuItems.drug;
              ref.read(isOpenAddDrugProvider.notifier).state = true;
            } else {
              ref.refresh(drugLoadProvider.notifier);
              ref
                  .read(DrawerKeyProvider.notifier)
                  .state
                  .currentState!
                  .openEndDrawer();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.home, color: Colors.white),
              Text(
                '  Add Drug',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        NeumorphicButton(
          style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: Colors.white),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.search, color: Colors.blue),
              Text(
                '  Search Drug',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
