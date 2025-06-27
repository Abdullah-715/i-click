import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/color_manger.dart';
import '../../resources/svg_manger.dart';
import '../../cubit/navigation_cubit/navigation_cubit.dart';
import 'nav_bar_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        int selectedIndex = state.index;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: BottomAppBar(
            shadowColor: AppColorManger.black1,
            surfaceTintColor: AppColorManger.white,
            shape: const CircularNotchedRectangle(),
            height: 75.h,
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                SizedBox(width: 20.w),
                //?Home Item :
                NavBarIcon(
                  selectedIndex: selectedIndex,
                  notSelectedSvg: AppSvgManger.home,
                  selectedSvg: AppSvgManger.homeColored,
                  index: 0,
                  onPressed: () {
                    context.read<NavigationCubit>().changeIndex(0);
                  },
                ),
                SizedBox(width: 30.w),
                //?Search Item :
                NavBarIcon(
                  selectedIndex: selectedIndex,
                  notSelectedSvg: AppSvgManger.search,
                  selectedSvg: AppSvgManger.searchColored,
                  index: 1,
                  onPressed: () {
                    context.read<NavigationCubit>().changeIndex(1);
                  },
                ),
                const Spacer(),
                //?Notifications Item :
                NavBarIcon(
                  selectedIndex: selectedIndex,
                  notSelectedSvg: AppSvgManger.notifications,
                  selectedSvg: AppSvgManger.notificationsColored,
                  index: 2,
                  onPressed: () {
                    context.read<NavigationCubit>().changeIndex(2);
                  },
                ),
                SizedBox(width: 30.w),

                //?Profile Item :
                NavBarIcon(
                  selectedIndex: selectedIndex,
                  notSelectedSvg: AppSvgManger.profile,
                  selectedSvg: AppSvgManger.profileColored,
                  index: 3,
                  onPressed: () {
                    context.read<NavigationCubit>().changeIndex(3);
                  },
                ),
                SizedBox(width: 20.w),
              ],
            ),
          ),
        );
      },
    );
  }
}
