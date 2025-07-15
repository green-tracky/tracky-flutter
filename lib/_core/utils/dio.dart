import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // kIsWeb 사용
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: kIsWeb
          ? 'http://localhost:8080/s/api' // Web에서는 localhost
          : 'http://10.0.2.2:8080/s/api',  // Emulator에서는 10.0.2.2
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  return dio;
});
