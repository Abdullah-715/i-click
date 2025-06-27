import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../cubit/chat_cubit.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import 'chat_item.dart';

class ChatItemsList extends StatelessWidget {
  const ChatItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state.status == DeafultBlocStatus.error) {
          AppToast.errorToast(state.msg);
        }
      },
      builder: (context, state) {
        if (state.status == DeafultBlocStatus.error &&
            state.lastMessages.isEmpty) {
          return ErrorTextWidget(
              message: state.msg,
              isList: false,
              onRefresh: () async {
                context.read<ChatCubit>().getLastMessage();
              });
        } else if (state.status == DeafultBlocStatus.loading &&
            state.lastMessages.isEmpty) {
          return ShimmerWidget(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            margin: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            width: double.infinity,
            height: 103.h,
            decoration: BoxDecoration(
              color: AppColorManger.primaryBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Spacer(),
          ));
        } else if (state.status == DeafultBlocStatus.done &&
            state.lastMessages.isEmpty) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 50.h),
            child: Text(
              "There is no chats here yet",
              style: Styles.body1.copyWith(color: AppColorManger.greyTow),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Expanded(
            child: ListView.separated(
          separatorBuilder: (context, _) => SizedBox(height: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          itemCount: state.lastMessages.length,
          itemBuilder: (context, index) => ChatItem(
            message: state.lastMessages[index],
          ),
        ));
      },
    );
  }
}
