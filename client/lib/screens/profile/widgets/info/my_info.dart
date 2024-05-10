import 'package:flutter/material.dart';

import 'modify_info.dart';
import 'package:client/constants.dart';
import 'package:client/widgets/custom_button.dart';
import '../../model/member_model.dart';
import '../logout_button.dart';

class MyInfo extends StatelessWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);

  final Member member;
  const MyInfo(this.member, {super.key});

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
                Text(member.name!,
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                Text('생일',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text(member.birthday==null? '생일을 설정해주세요' : member.birthday!,
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                Text('카카오 ID',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text('게스트 로그인 상태입니다',
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
            ],
          ),
          SizedBox(height: 32),
          CustomButton(
            text: '수정하기',
            func: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModifyInfo(member: member,)));
            },
          ),
          SizedBox(height: 8),
          LogoutButton(),
        ],
      ),
    );
  }
}
