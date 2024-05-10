import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:client/widgets/custom_button.dart';

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
    final textTheme = Theme.of(context).textTheme;

    Text titleText = Text(
      '정말 로그아웃하시겠어요?',
      style: textTheme.displayMedium,
    );
    Text contentText = Text(
        '게스트 로그인 상태에서 로그아웃할 경우 같은 계정으로 다시 로그인할 수 없어요.',
        style: textTheme.displaySmall,
    );
    return CustomButton(
      text: '로그아웃',
      color: 200,
      func: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: titleText,
              content: contentText,
              actions: [
                TextButton(child: const Text('로그아웃'), onPressed: () => logout()),
                TextButton(
                  child: const Text('취소'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
