import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/color_manger.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon(
      {super.key,
      this.onPressed,
      required this.selectedIndex,
      required this.notSelectedSvg,
      required this.selectedSvg,
      required this.index});
  final void Function()? onPressed;
  final int selectedIndex;
  final String notSelectedSvg;
  final String selectedSvg;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: selectedIndex == index
          ? SvgPicture.asset(selectedSvg)
          : SvgPicture.asset(
              notSelectedSvg,
              colorFilter: ColorFilter.mode(
                  AppColorManger.textTertiary, BlendMode.srcIn),
            ),
    );
  }
}
