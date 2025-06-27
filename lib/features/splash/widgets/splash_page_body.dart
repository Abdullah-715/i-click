import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resources/png_manger.dart';
import '../../../core/resources/svg_manger.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({
    super.key,
  });

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody>
    with SingleTickerProviderStateMixin {
  late AnimationController controller1;
  late Animation<double> sizeAnimationSmallStart;
  late Animation<double> sizeAnimationBigStart;

  double opacity = 1.0;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200))
      ..repeat(reverse: true);

    sizeAnimationSmallStart = Tween<double>(
      begin: 1,
      end: 2,
    ).animate(controller1)
      ..addStatusListener((state) {
      
      });

    sizeAnimationBigStart = Tween<double>(
      begin: 2,
      end: 1,
    ).animate(controller1)
      ..addStatusListener((state) {
      
      });
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 121.h,
        ),
        SvgPicture.asset(AppSvgManger.iclick),
        SizedBox(
          height: 40.h,
        ),
        SizedBox(
            height: 422.h,
            width: 345.w,
            child: Image.asset(AppPngManger.firstScreenCenter)),
        SizedBox(
          height: 20.h,
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: opacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              AnimatedBuilder(
                  animation: sizeAnimationSmallStart,
                  builder: (context, _) {
                    return ScaleTransition(
                      scale: sizeAnimationSmallStart,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    );
                  }),
              const SizedBox(
                width: 10,
              ),
              AnimatedBuilder(
                  animation: sizeAnimationBigStart,
                  builder: (context, _) {
                    return ScaleTransition(
                      scale: sizeAnimationBigStart,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    );
                  }),
              const SizedBox(
                width: 10,
              ),
              AnimatedBuilder(
                  animation: sizeAnimationSmallStart,
                  builder: (context, _) {
                    return ScaleTransition(
                      scale: sizeAnimationSmallStart,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    );
                  })
            ],
          ),
        )
      ],
    );
  }
}
