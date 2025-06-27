import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/reset_password_bottom_sheet.dart';
import '../widgets/welcome_iclick_background.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeIclickBackground(
      bottomSheet: ResetPasswordBottomSheet(),
    );
  }
}
