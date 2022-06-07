import 'package:flutter/material.dart';

import '../addons/breakpoint.dart';
import 'counter_badge.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    required this.isActive,
    this.isHover = false,
    required this.itemCount,
    this.showBorder = true,
    required this.icon,
    required this.title,
    required this.press,
  });

  final bool isActive, isHover, showBorder;
  final int itemCount;
  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.only(bottom: 15, right: 5),
          decoration: showBorder
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFDFE2EF)),
                  ),
                )
              : null,
          child: Row(
            children: [
              if (title == 'Lock')
                Hero(
                  tag: 'lockBtn',
                  child: Icon(
                    icon,
                    // color: (isActive || isHover) ? kPrimaryColor : kGrayColor,
                    color: Colors.red,
                  ),
                ),
              if (title != 'Lock')
                Icon(
                  icon,
                  color: (isActive || isHover) ? kPrimaryColor : kGrayColor,
                ),
              const SizedBox(width: kDefaultPadding * 0.75),
              Text(
                title,
                style: TextStyle(
                  color: (isActive || isHover) ? kTextColor : kGrayColor,
                ),
              ),
              const Spacer(),
              if (itemCount > 0) CounterBadge(itemCount)
            ],
          ),
        ),
      ),
    );
  }
}
