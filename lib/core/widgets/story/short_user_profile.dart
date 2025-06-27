import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../resources/color_manger.dart';
import '../../resources/styles.dart';
import '../user_image_or_letter_widget.dart';
import '../../../features/auth/domain/entities/user_entity.dart';
import '../../../router/routes.dart';

class ShortUserProfile extends StatelessWidget {
  final UserEntity user;
  const ShortUserProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        GoRouter.of(context).push(AppRoutes.profilePage, extra: user.id);
      },
      leading: UserImageOrLetterWidget(
          id: user.id!, image: user.imageUrl!, name: user.name!),
      title: Text(
        user.name ?? '',
        style: Styles.body3,
      ),
      subtitle: Text(
        user.displayName ?? '',
        style: Styles.body4.copyWith(color: AppColorManger.greyThree),
      ),
    );
  }
}
