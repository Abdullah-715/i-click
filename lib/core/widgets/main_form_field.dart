import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manger.dart';
import '../resources/input_border.dart';

class MainFormField extends StatelessWidget {
  final String hint;
  final Widget? icon;
  final bool? readOnly;
  final double? radius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  const MainFormField({
    this.onTap,
    super.key,
    required this.hint,
    this.icon,
    this.readOnly = false,
    this.radius = 30,
    this.horizontalPadding,
    this.verticalPadding,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.hintStyle,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.minLines,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius!)),
      child: TextFormField(
        onTap: onTap,
        initialValue: labelText,
        minLines: minLines,
        maxLines: maxLines,
        onChanged: onChanged,
        readOnly: readOnly!,
        validator: validator,
        cursorColor: AppColorManger.primaryColor,
        decoration: InputDecoration(
          errorStyle: hintStyle?.copyWith(color: AppColorManger.primaryColor),
          fillColor: AppColorManger.fieldBackground,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 0,
              vertical: verticalPadding ?? 0),
          hintText: hint,
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstraints,
          hintStyle: hintStyle,
          focusedErrorBorder: readOnly == false
              ? FiledBorder().colorInputBorder(radius!.r)
              : FiledBorder().normalInputBorder(radius!.r),
          focusedBorder: readOnly == false
              ? FiledBorder().colorInputBorder(radius!.r)
              : FiledBorder().normalInputBorder(radius!.r),
          border: readOnly == false
              ? FiledBorder().colorInputBorder(radius!.r)
              : FiledBorder().normalInputBorder(radius!.r),
          enabledBorder: FiledBorder().normalInputBorder(radius!.r),
          errorBorder: readOnly == false
              ? FiledBorder().colorInputBorder(radius!.r)
              : FiledBorder().normalInputBorder(radius!.r),
        ),
      ),
    );
  }
}
