import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/widgets/alert/app_alert.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/profile_data/profile_data_cubit.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/edit_profile_page_head.dart';

class EditProfilePage extends StatelessWidget {
  final UserEntity user;
  EditProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    bool isRefresh = false;
    return BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          //? For edit profile :
          if (state.event == ProfileEvent.updateProfile) {
            //? Done :
            if (state.status == DeafultBlocStatus.done) {
              isRefresh = true;
              GoRouter.of(context).pop();
              GoRouter.of(context).pop(isRefresh);
            }

            //? Loading :
            if (state.status == DeafultBlocStatus.loading) {
              AppAlert.lodingAlert(context);
            }

            //? Error :
            if (state.status == DeafultBlocStatus.error) {
              GoRouter.of(context).pop();
              AppToast.errorToast(state.message);
            }
          }

          //? For pick image :
          if (state.event == ProfileEvent.pickImage) {
            if (state.status == DeafultBlocStatus.done && state.file != null) {
              isRefresh = true;
              context.read<ProfileCubit>().addImage(user: user);
            }
          }

          //? For upload image :
          if (state.event == ProfileEvent.addImage) {
            //? Loading :
            if (state.status == DeafultBlocStatus.loading &&
                state.file != null) {
              AppAlert.lodingAlert(context);
            }

            //? Error :
            if (state.status == DeafultBlocStatus.error) {
              GoRouter.of(context).pop();
              AppToast.errorToast(state.message);
            }

            //? Done :
            if (state.status == DeafultBlocStatus.done) {
              isRefresh = true;
              GoRouter.of(context).pop(isRefresh);
              GoRouter.of(context).pop(isRefresh);
              GoRouter.of(context).pop(isRefresh);
              AppToast.doneToast('Your image updated succesfully!');
              context.read<ProfileCubit>().getProfileData(
                  profileId: AppSharedPref.getUserId()!, isFirst: true);
            }
          }

          //? for delete image :
          if (state.event == ProfileEvent.deleteImage) {
            //? Loading :
            if (state.status == DeafultBlocStatus.loading) {
              GoRouter.of(context).pop();
              AppAlert.lodingAlert(context);
            }

            //? Error :
            if (state.status == DeafultBlocStatus.error) {
              GoRouter.of(context).pop();
              AppToast.errorToast(state.message);
            }

            //? Done :
            if (state.status == DeafultBlocStatus.done) {
              isRefresh = true;
              GoRouter.of(context).pop();
              GoRouter.of(context).pop();
              GoRouter.of(context).pop(isRefresh);
              AppToast.doneToast('Your image updated succesfully!');
  }
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                EditProfilePageHead(user: user, isRefresh: isRefresh),
                SizedBox(height: 55.h),
                EditProfileForm(user: user),
              ],
            ),
          ),
        ));
  }
}
