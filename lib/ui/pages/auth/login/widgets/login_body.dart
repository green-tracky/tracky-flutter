import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/auth/login/widgets/login_button.dart';
import 'package:tracky_flutter/ui/pages/auth/login/widgets/login_logo.dart';
import 'package:tracky_flutter/ui/pages/auth/login/widgets/login_text.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 상단 로고
        LoginLogo(),
        // 가운데 문구
        LoginText(),
        // 카카오 로그인 버튼
        LoginButton(),
      ],
    );
  }
}





