import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/constants.dart';
import 'package:client/widgets/header.dart';
import 'package:client/widgets/input_box.dart';
import 'package:client/widgets/custom_button.dart';
import 'package:client/service/member_api.dart';

import '../../model/member_model.dart';

class ModifyInfo extends StatefulWidget {
  final Member member;
  const ModifyInfo({super.key, required this.member});

  @override
  State<ModifyInfo> createState() => _ModifyInfoState();
}

class _ModifyInfoState extends State<ModifyInfo> {
  late Member member; // 멤버 정보를 저장할 변수 추가
  var nickname = TextEditingController(); // 닉네임 입력 저장
  var birthday = TextEditingController(); // 생일 입력 저장

  @override
  void initState() {
    super.initState();
    member = widget.member; // widget의 member를 초기화
    nickname.text = member.name!;
    if (member.birthday!=null) birthday.text = member.birthday!;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<MemberApi>(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(title:'내 정보 수정',
            buttonList: [IconButton(
              icon: Icon(Icons.check),
              padding: EdgeInsets.all(32),
              iconSize: 32,
              onPressed: () async {
                if (nickname.text!=null && birthday.text!=null) {
                  provider.updateMemberInfo(Member(name: nickname.text, birthday: birthday.text));
                  Navigator.pop(context);
                }
              },
            )],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/avatar.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(18),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: '사진 바꾸기',
                            size: 'small',
                            func: () {
                              print('image modify button clicked');
                            },
                          ),
                          CustomButton(
                            text: '사진 초기화',
                            size: 'small',
                            color: 200,
                            func: () {
                              print('image initialize button clicked');
                            },
                          ),
                        ]),
                  ),
                  InputBox(
                    controller: nickname,
                    name: 'nickname',
                    placeholder: '닉네임',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.person),
                      iconSize: 32,
                      color: Constants.main500,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      onPressed: () {},
                    ),
                  ),
                  InputBox(
                    controller: birthday,
                    name: 'birthday',
                    placeholder: '생일 (YYYY-MM-DD 형식)',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.cake),
                      iconSize: 32,
                      color: Constants.main500,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      onPressed: () {},
                    ),
                  ),
                ])),
              ),
            ],
          ),
        )));
  }
}
