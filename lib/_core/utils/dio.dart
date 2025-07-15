import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // kIsWeb

final dio = Dio(
  BaseOptions(
    baseUrl: kIsWeb ? 'http://localhost:8080/s/api' : 'http://10.0.2.2:8080/s/api',
    headers: {'Content-Type': 'application/json'},
  ),
);

final dioProvider = Provider<Dio>((ref) => dio);