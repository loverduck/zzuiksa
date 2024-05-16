import 'dart:convert';

import 'package:client/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<dynamic> getKakaoToken() async {
  // 카카오톡이 설치되어 있는 경우
  if (await isKakaoTalkInstalled()) {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      return token.accessToken;
    } catch (e) {
      print("카카오톡으로 로그인 실패: $e");

      // 카카오 설치 O 권한 요청에서 취소
      if (e is PlatformException && e.code == "CANCELED") {
        return;
      }

      try {
        // 카카오 계정으로 로그인 시도
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        return token.accessToken;
      } catch (e) {
        print("카카오 계정으로 로그인 실패: $e");
        return;
      }
    }
  } else {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      return token.accessToken;
    } catch (e) {
      print("카카오 계정으로 로그인 실패: $e");
      return;
    }
  }
}

Future<dynamic> kakaoLogin() async {
  String? token = await getKakaoToken();

  if (token == null) {
    return;
  }

  try {
    final res = await http.post(
      Uri.parse(("$baseUrl/api/auth/login/kakao")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "accessToken": token,
      }),
    );

    Map<String, dynamic> json = jsonDecode(res.body);

    try {
      if (json["status"] == "success") {
        storage.write(key: "login", value: json['data']['accessToken']);
      }
    } catch (e) {
      print("storage write error: $e");
      return;
    }
    return json;
  } catch (e) {
    print("getRoute error: $e");
    return;
  }
}
