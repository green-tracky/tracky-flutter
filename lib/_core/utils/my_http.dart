import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final baseUrl = "http://tracky-v1-env.eba-8i2xvmqp.ap-northeast-2.elasticbeanstalk.com"; // cmd -> ipconfig -> ip주소 적기

//로그인 되면, dio에 jwt 추가하기
//dio.options.headers['Authorization'] = 'Bearer $_accessToken';
final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl, // 내 IP 입력
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 10),
    contentType: "application/json; charset=utf-8",
    validateStatus: (status) => true, // 200 이 아니어도 예외 발생안하게 설정 -> 메시지 확인용
  ),
);

const secureStorage = FlutterSecureStorage();
final dioProvider = Provider<Dio>((ref) => dio);
