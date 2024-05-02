import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class WithdrawalButton extends StatelessWidget {
  const WithdrawalButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: () {
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
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Constants.main200),
          side: MaterialStateProperty.all(
              BorderSide(width: 2.0, color: Constants.main600)),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          )),
      child: Text(
        '탈퇴하기',
        style: textTheme.displaySmall,
      ),
    );
  }
}
