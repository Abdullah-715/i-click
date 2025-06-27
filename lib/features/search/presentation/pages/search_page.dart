import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/story/short_user_profile.dart';
import '../../../profile/presentation/widgets/profile_items_list.dart';
import '../../../profile/presentation/widgets/tab_bar_widget.dart';
import '../cubit/cubit/search_cubit.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../../core/widgets/main_form_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool _) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(top: 45.h),
                    child: const SearchPageAppBar(),
                  ),
                )
              ];
            },
            body: SearchPageBody(),
          )),
    );
  }
}

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state.status == DeafultBlocStatus.loading) {
              return TabBarWidget(
                postsCount: 0,
                storiesCont: 0,
                isSearch: true,
              );
            }
            return TabBarWidget(
              postsCount: state.searchEntity.users.length,
              storiesCont: state.searchEntity.posts.length,
              isSearch: true,
            );
          },
        ),
        Expanded(
          child: TabBarView(
            children: [
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.status == DeafultBlocStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == DeafultBlocStatus.done) {
                    if (state.searchEntity.users.isEmpty) {
                      return Center(
                        child: Text(
                          'No data found',
                          style: Styles.body1
                              .copyWith(color: AppColorManger.greyThree),
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.searchEntity.users.length,
                        itemBuilder: (context, index) {
                          return ShortUserProfile(
                              user: state.searchEntity.users[index]);
                        });
                  }
                  return Center(
                    child: Text(
                      'Start searching now...',
                      style: Styles.body1
                          .copyWith(color: AppColorManger.greyThree),
                    ),
                  );
                },
              ),
              BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {
                  if (state.status == DeafultBlocStatus.error) {
                    AppToast.errorToast(state.message);
                  }
                },
                builder: (context, state) {
                  if (state.status == DeafultBlocStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == DeafultBlocStatus.done) {
                    if (state.searchEntity.posts.isEmpty) {
                      return Center(
                        child: Text(
                          'No data found',
                          style: Styles.body1
                              .copyWith(color: AppColorManger.greyThree),
                        ),
                      );
                    }
                    return ProfileItemsList(posts: state.searchEntity.posts);
                  } else if (state.status == DeafultBlocStatus.error) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Styles.body1
                            .copyWith(color: AppColorManger.greyThree),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      'Start searching now...',
                      style: Styles.body1
                          .copyWith(color: AppColorManger.greyThree),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SearchPageAppBar extends StatelessWidget {
  const SearchPageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: MainFormField(
        onChanged: (val) {
          if (val.isNotEmpty) {
            context.read<SearchCubit>().getSearch(search: val);
          }
        },
        hint: 'Type Something',
        hintStyle: Styles.body4.copyWith(color: AppColorManger.textPlaceholder),
        verticalPadding: 8.h,
        horizontalPadding: 14.w,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 6.w),
          child: SvgPicture.asset(AppSvgManger.searchColored),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 20.w),
      ),
    );
  }
}
