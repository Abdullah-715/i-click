import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/short_users_cubit/short_users_cubit.dart';
import '../../resources/enum_manger.dart';
import '../../resources/styles.dart';
import 'short_user_profile.dart';
import '../../../features/auth/domain/entities/user_entity.dart';

class StoryViewsBottomSheet extends StatelessWidget {
  const StoryViewsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShortUsersCubit, ShortUsersState>(
      builder: (context, state) {
        if (state.status == DeafultBlocStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == DeafultBlocStatus.done) {
          return bottomSheet(state.users);
        }
        return const SizedBox();
      },
    );
  }

  Container bottomSheet(List<UserEntity> users) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
     
      child: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Views:",
              style: Styles.bodySemibold,
            ),
          ),
          ...users.map<Widget>((user) => ShortUserProfile(user: user)),
        ],
      ),
    );
  }
}
