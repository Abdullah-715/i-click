import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/font_manger.dart';
import '../resources/color_manger.dart';
import '../resources/styles.dart';

class UserImageOrLetterWidget extends StatelessWidget {
  const UserImageOrLetterWidget({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    this.width,
    this.height,
    this.fontSize,
  });

  final String id, image, name;
  final double? width, height , fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  width?? 30.w,
      height: height?? 30.w,
      alignment: image != id ? null : Alignment.center,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: AppColorManger.greyFive),
      child: (image != id || image.contains('.com'))
          ? ClipOval(
              child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
            ))
          : Text(
              name[0].toUpperCase(),
              style: Styles.body4.copyWith(
                color: AppColorManger.primaryColor,
                fontSize: fontSize ?? AppFontSizeManger.s14,
              ),
            ),
    );
  }
}
