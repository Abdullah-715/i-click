import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/sign_up_bottom_sheet.dart';
import '../widgets/welcome_background.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeBackGround(bottomSheet: SignUpBottomSheet());
  }
}
