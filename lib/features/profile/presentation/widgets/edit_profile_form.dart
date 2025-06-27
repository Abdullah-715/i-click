import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/functions/validation_functions.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_form_field.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/profile_data/profile_data_cubit.dart';

class EditProfileForm extends StatelessWidget {
  final UserEntity user;
  const EditProfileForm({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    String userName = user.name!;
    String displayName = user.displayName!;
    String bio = user.bio!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //?  Name field :
              Text(
                'Name',
                style:
                    Styles.title3.copyWith(color: AppColorManger.textPrimary),
              ),
              MainFormField(
                onChanged: (val) => userName = val,
                validator: (val) => AppValidation().validation(val),
                labelText: user.name,
                hint: 'Name',
                hintStyle: Styles.body3
                    .copyWith(color: AppColorManger.textPlaceholder),
                horizontalPadding: 20.w,
                verticalPadding: 13.h,
              ),
              SizedBox(height: 30.h),

              //?  Display name :
              Text(
                'Display name',
                style:
                    Styles.title3.copyWith(color: AppColorManger.textPrimary),
              ),
              MainFormField(
                onChanged: (val) => displayName = val,
                validator: (val) => AppValidation().validation(val),
                labelText: user.displayName,
                hint: 'Display name',
                hintStyle: Styles.body3
                    .copyWith(color: AppColorManger.textPlaceholder),
                horizontalPadding: 20.w,
                verticalPadding: 13.h,
              ),
              SizedBox(height: 30.h),

              //?  bio  :
              Text(
                'Bio',
                style:
                    Styles.title3.copyWith(color: AppColorManger.textPrimary),
              ),
              MainFormField(
                maxLines: 6,
                onChanged: (val) => bio = val,
                labelText: user.bio,
                hint: 'Write any bio...',
                hintStyle: Styles.body3
                    .copyWith(color: AppColorManger.textPlaceholder),
                horizontalPadding: 20.w,
                verticalPadding: 13.h,
              ),
              SizedBox(height: 30.h),

              //?  Email field :
              Text(
                'Email',
                style:
                    Styles.title3.copyWith(color: AppColorManger.textPrimary),
              ),
              MainFormField(
                readOnly: true,
                labelText: user.email,
                hint: 'Email',
                hintStyle: Styles.body3
                    .copyWith(color: AppColorManger.textPlaceholder),
                horizontalPadding: 20.w,
                verticalPadding: 13.h,
              ),
              SizedBox(height: 30.h),
              MainButton(
                label: 'SAVE CHANGES',
                onPressed: () {
                  if (key.currentState!.validate()) {
                    final userUpdated = UserEntity(
                      id: user.id,
                      name: userName,
                      displayName: displayName,
                      bio: bio,
                    );

                    context
                        .read<ProfileCubit>()
                        .updateProfile(user: userUpdated);
                  }
                },
              ),
              SizedBox(height: 30.h),
            ],
          )),
    );
  }
}
