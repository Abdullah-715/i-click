import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/color_manger.dart';
import '../../resources/svg_manger.dart';

class AddButton extends StatelessWidget {
  final void Function()? onPressed;
  const AddButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      onPressed: () {},
      child: ClipOval(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppColorManger.primaryLinearTow,
              AppColorManger.primaryLinearOne,
            ])),
            child: MaterialButton(
                padding: const EdgeInsets.all(18),
                onPressed: onPressed,
                child: SvgPicture.asset(AppSvgManger.add))),
      ),
    );
  }
}
