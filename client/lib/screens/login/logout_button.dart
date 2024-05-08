import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // flutter_secure_storage 패키지

class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  logout() async {
    await storage.delete(key: 'login');
    Navigator.pushNamed(context, '/');
  }

  checkUserState() async {
    userInfo = await storage.read(key: 'login');
    if (userInfo == null) {
      print('로그인 페이지로 이동');
      Navigator.pushNamed(context, '/'); // 로그인 페이지로 이동
    } else {
      print('로그인 중');
    }
  }

  @override
  void initState() {
    super.initState();
    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      tooltip: 'logout',
      onPressed: () {
        logout();
      },
    );
  }
}
