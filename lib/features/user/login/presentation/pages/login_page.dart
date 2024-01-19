import 'package:flutter/material.dart';

import 'package:flutter_r5_app/features/user/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BasePage(isLogin: true),
    );
  }
}
