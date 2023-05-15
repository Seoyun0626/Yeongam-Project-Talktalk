import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class WithdrawalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const TextCustom(
                text: '회원탈퇴',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.primary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: Column(children: []),
            )));
  }
}
