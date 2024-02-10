
// ignore_for_file: library_prefixes

import 'package:flutter/foundation.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;

import '../global/dio.dart';

class PointApi extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Future getpoints() async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'points/get-points',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
       if (response.data["message"] == "Unauthenticated") {
           EasyLoading.dismiss();
    
        return false;
      }
      return response.data['data']['points'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
  Future replacepoints() async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'points/redeem-points',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
