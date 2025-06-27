import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/profile_data/profile_data_cubit.dart';
import '../pages/profile_page.dart';
import 'profile_details_section.dart';
import 'profile_head_section.dart';
import 'profile_items_list.dart';
import 'profile_page_story_list.dart';
import 'tab_bar_widget.dart';

class ProfilePageBody extends StatelessWidget {
  final UserEntity user;
  const ProfilePageBody({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: ProfileHeadSection(
                isMyPage: user.id! == AppSharedPref.getUserId()!,
                user: user,
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileDetailsSection(user: user),
            ),
            SliverToBoxAdapter(
              child: TabBarWidget(
                postsCount: user.posts?.length ?? 0,
                storiesCont: user.stories?.length ?? 0,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            RefreshList(
              onRefresh: () async {
                context
                    .read<ProfileCubit>()
                    .getProfileData(profileId: user.id!);
              },
              child: ProfileItemsList(
                posts: user.posts ?? [],
              ),
            ),
            RefreshList(
                onRefresh: () async {
                  context.read<AuthCubit>().logout();
                  context.read<ProfileCubit>().getProfileData(
                      profileId: user.id ?? AppSharedPref.getUserId()!);
                },
                child: ProfileStoriesList(stories: user.stories)),
          ],
        ),
      ),
    );
  }
}
