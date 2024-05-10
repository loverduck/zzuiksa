import 'package:flutter/material.dart';

import '../../model/member_model.dart';
import 'modify_info.dart';
import 'package:client/constants.dart';
import 'package:client/widgets/custom_button.dart';

class MyInfo extends StatelessWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);
  Member me = Member(name: '임시이름', birthday: '임시생일', profileImage: '임시프로필');

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Table(
            columnWidths: {
              0: FixedColumnWidth(80.0),
              1: FixedColumnWidth(160.0),
            },
            children: [
              TableRow(children: [
                Text('닉네임',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text(me.name!,
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                Text('생일',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text(me.birthday!,
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                Text('카카오 ID',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text('kim@ssafy.com',
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
            ],
          ),
          SizedBox(height: 20),
          CustomButton(
            text: '수정하기',
            func: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModifyInfo()));
            },
          ),
          SizedBox(height: 8),
          CustomButton(
            text: '탈퇴하기',
            color: 200,
            func: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('회원 탈퇴'),
                    content: Text('정말 탈퇴하시겠어요?'),
                    actions: [
                      TextButton(
                        child: const Text('예'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('아니오'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
