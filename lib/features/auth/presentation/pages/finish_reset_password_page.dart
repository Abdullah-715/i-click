import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/finish_reset_password_bottom_sheet.dart';
import '../widgets/welcome_iclick_background.dart';

class FinishResetPasswordPage extends StatelessWidget {
  const FinishResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeIclickBackground(
      bottomSheet: FinishResetPasswordBottomSheet(),
    );
  }
}
