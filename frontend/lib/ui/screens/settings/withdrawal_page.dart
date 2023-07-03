import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_withdrawal.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({super.key});

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
              child: Column(children: [
                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: BtnNaru(
                          margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                          text: '탈퇴하기',
                          width: 120.w,
                          height: 50.h,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          colorText: Colors.white,
                          // backgroundColor:
                          //     completeAgree ? ThemeColors.primary : Colors.grey,
                          onPressed: () {
                            modalWithdrawal(context);
                          })),
                )
              ]),
            )));
  }
}
