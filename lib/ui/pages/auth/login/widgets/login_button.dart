import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFE812),
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () async {
            // TODO: 카카오 로그인 로직
            try {
              OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
              print('카카오계정으로 로그인 성공 ${token.idToken}');
              Navigator.pushReplacementNamed(context, '/join');
            } catch (error) {
              print('카카오계정으로 로그인 실패 $error');
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/kakao_logo.png', // ← 카카오 로고 이미지
                width: 36,
                height: 32,
              ),
              const SizedBox(width: 8),
              const Text(
                "카카오로 계속하기",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
