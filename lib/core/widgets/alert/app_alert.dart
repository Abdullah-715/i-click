import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../resources/color_manger.dart';
import '../../resources/styles.dart';

class AppAlert {
  static void lodingAlert(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static void mainDialog(
    BuildContext context, {
    required String title,
    required String body,
    required String button,
    required VoidCallback onPress
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              content: Container(
                color: AppColorManger.white,
                height: 160.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Styles.title1
                          .copyWith(color: AppColorManger.primaryColor),
                    ),
                    Divider(
                      height: 13.h,
                      indent: 3.h,
                      color: AppColorManger.greyFoor,
                    ),
                    Text(
                      body,
                      style: Styles.body3,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: Styles.body4.copyWith(
                              color: AppColorManger.primaryColor,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(
                                color: AppColorManger.greyFoor,
                                width: 2,
                              )),
                        ),
                        SizedBox(width: 15.w),
                        MaterialButton(
                          onPressed: onPress,
                          child: Text(
                            button,
                            style: Styles.body4.copyWith(
                              color: AppColorManger.white,
                            ),
                          ),
                          color: AppColorManger.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
