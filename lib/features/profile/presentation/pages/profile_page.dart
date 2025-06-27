import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/styles.dart';
import '../cubit/profile_data/profile_data_cubit.dart';
import '../widgets/profile_page_body.dart';
import '../widgets/profile_shimmer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status == DeafultBlocStatus.error) {
          return ErrorTextWidget(
            message: state.message,
            onRefresh: () async {
              if (state.user.id == null) {
                GoRouter.of(context).pop();
              } else {
                context
                    .read<ProfileCubit>()
                    .getProfileData(profileId: state.user.id!);
              }
            },
          );
        } else if (state.status == DeafultBlocStatus.loading &&
            state.user.id == null) {
          return const ProfileShimmer();
        }
        return ProfilePageBody(user: state.user);
      },
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget(
      {super.key,
      this.button,
      required this.message,
      required this.onRefresh,
      this.isList = true});
  final String message;
  final String? button;
  final bool isList;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return isList ? errorList() : errorWidget();
  }

  Widget errorWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 250.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Styles.heading,
            ),
            MaterialButton(
              onPressed: onRefresh,
              color: AppColorManger.primaryLinearTow,
              child: Text(
                button ?? 'Try again...',
                style: Styles.body4.copyWith(color: AppColorManger.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorList() {
    return RefreshList(onRefresh: onRefresh, children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 250.h),
            Text(
              message,
              style: Styles.heading,
            ),
            MaterialButton(
              onPressed: onRefresh,
              color: AppColorManger.primaryLinearTow,
              child: Text(
                button ?? 'Try again...',
                style: Styles.body4.copyWith(color: AppColorManger.white),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class RefreshList extends StatelessWidget {
  const RefreshList({
    super.key,
    this.child,
    this.children,
    required this.onRefresh,
  });
  final Widget? child;
  final List<Widget>? children;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: child ?? ListView(children: children!),
    );
  }
}
