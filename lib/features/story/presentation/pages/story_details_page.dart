import 'package:flutter/material.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/cubit/story_cubit_cubit.dart';
import '../widgets/story_details_page/story_details_widget.dart';

class StoryDetailsPage extends StatefulWidget {
  const StoryDetailsPage({super.key, required this.story});
  final UserEntity story;

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  late PageController contoller;
  @override
  void initState() {
    super.initState();
    contoller =
        PageController(initialPage: storiesFromCubit.indexOf(widget.story));
    
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.story.id!,
      child: Scaffold(
          backgroundColor: AppColorManger.black2,
          body: PageView(
            controller: contoller,
            children: storiesFromCubit
                .map((story) =>
                    StoryDetailsWidget(user: story, pageController: contoller))
                .toList(),
          )),
    );
  }
}
