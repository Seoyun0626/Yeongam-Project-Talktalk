import 'package:flutter/material.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

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
                      alignment: Alignment.bottomCenter,
                      child: BtnNaru(
                          text: '탈퇴하기',
                          width: 350,
                          height: 50,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          colorText: Colors.white,
                          // backgroundColor:
                          //     completeAgree ? ThemeColors.primary : Colors.grey,
                          onPressed: () {})),
                )
              ]),
            )));
  }
}
