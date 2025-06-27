import 'package:flutter/material.dart';
import '../../../core/resources/png_manger.dart';
import '../widgets/get_started_page_body.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppPngManger.backGroundIntro),
        ),
      ),
      child: const GetStartedPageBody(),
    ));
  }
}
