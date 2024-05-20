import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static CircularProgressIndicator showIndicator() {
    return const CircularProgressIndicator(
      strokeWidth: 6.0,
      valueColor: AlwaysStoppedAnimation<Color>(
          Colors.pink), // 필요한 경우 Constants.pink400로 변경
    );
  }

  static void showDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.pink), // 필요한 경우 Constants.pink400로 변경
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // 이 부분은 사실 필요하지 않습니다.
  }
}
