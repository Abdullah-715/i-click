import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/input_border.dart';
import '../../../../core/resources/svg_manger.dart';

class PasswordField extends StatelessWidget {
  final String hint;
  final Widget? icon;
  final bool? readOnly;
  final double? radius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Function(String)? onChanged;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  const PasswordField({
    super.key,
    required this.hint,
    this.icon,
    this.readOnly,
    this.radius = 30,
    this.horizontalPadding,
    this.verticalPadding,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.hintStyle,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    bool isHide = false;
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius!)),
        child: StatefulBuilder(
          builder: (context, setState) => TextFormField(
            validator: validator,
            onChanged: onChanged,
            obscureText: !isHide,
            cursorColor: AppColorManger.primaryColor,
            decoration: InputDecoration(
              errorStyle:
                  hintStyle?.copyWith(color: AppColorManger.primaryColor),
              fillColor: AppColorManger.fieldBackground,
              filled: true,
              suffixIconConstraints: const BoxConstraints(maxHeight: 24),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    child: isHide == true
                        ? SvgPicture.asset(
                            AppSvgManger.eye,
                            colorFilter: ColorFilter.mode(
                              AppColorManger.textPrimary,
                              BlendMode.srcIn,
                            ),
                          )
                        : SvgPicture.asset(
                            AppSvgManger.eyeHide,
                          ),
                  )),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding ?? 0,
                  vertical: verticalPadding ?? 0),
              hintText: hint,
              prefixIcon: prefixIcon,
              prefixIconConstraints: prefixIconConstraints,
              hintStyle: hintStyle,
              focusedErrorBorder: FiledBorder().colorInputBorder(radius!.r),
              focusedBorder: FiledBorder().colorInputBorder(radius!),
              border: FiledBorder().colorInputBorder(radius!),
              enabledBorder: FiledBorder().normalInputBorder(radius!),
              errorBorder: FiledBorder().colorInputBorder(radius!),
            ),
          ),
        ));
  }
}
