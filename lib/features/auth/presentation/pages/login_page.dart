import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/login_bottom_sheet.dart';
import '../widgets/welcome_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeBackGround(
      bottomSheet: LoginBottomSheet(),
    );
  }
}
