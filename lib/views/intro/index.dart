import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroChatButton extends StatelessWidget {
  Function() onTap;
  Widget child;
  String backgroundImage;

  IntroChatButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundImage = "assets/images/image/introButtonBg.png",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.w),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fitWidth,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
