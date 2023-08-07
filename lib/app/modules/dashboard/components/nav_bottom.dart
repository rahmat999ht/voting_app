import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:voting_app/app/core/colors/colors_app.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int index)? onTabChange;
  final int selectedIndex;
  final bool isPres;
  const BottomNavBar({
    Key? key,
    this.onTabChange,
    required this.selectedIndex,
    required this.isPres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: ColorApp.primary,
            color: ColorApp.primary,
            tabs: [
              if (isPres == true)
                const GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
              const GButton(
                icon: LineIcons.barChartAlt,
                text: 'Card',
              ),
              const GButton(
                icon: LineIcons.checkCircleAlt,
                text: 'Hasil',
              ),
              const GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
