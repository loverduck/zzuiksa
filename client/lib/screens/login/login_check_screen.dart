import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:client/constants.dart';
import 'package:client/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'model/login_model.dart';
import 'package:client/service/notification/notification.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var accessToken = TextEditingController(); // id 입력 저장

  static const storage =
      FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    FlutterLocalNotification.init();
    super.initState();

    _permissionWithNotification();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _permissionWithNotification() async {
    await [Permission.notification].request();
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      print('로그인이 필요합니다');
    }
  }

  // 로그인 버튼 누르면 실행
  guestLogin() async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/auth/login/guest"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        final Login token =
        Login.fromJson(json.decode(res.body)['data']);

        await storage.write(
          key: 'login',
          value: jsonEncode(token),
        );
        print('guest login success');
        return true;
      } else {
        throw Exception('guest login failed');
      }
    } catch (e) {
      throw Exception("guest login error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              text: '카카오로 시작',
              color: 300,
              func: () {
                print('kakao login button clicked');
              }),
          SizedBox(height: 8),
          CustomButton(
              text: '게스트로 시작',
              color: 100,
              func: () async {
                if (await guestLogin() == true) {
                  Navigator.pushNamed(
                      context, '/home'); // 로그인 이후 서비스 화면으로 이동
                } else {
                  print('로그인 실패');
                }
              }),
        ],
      ),
    ));
  }
}
