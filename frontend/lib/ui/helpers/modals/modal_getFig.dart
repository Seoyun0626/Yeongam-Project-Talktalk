import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

void modalGetFig(
  BuildContext context,
) {
  showDialog(
    useRootNavigator: true,
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SizedBox(
        height: 220.h,
        width: 300.w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   '청소년 톡talk',
                //   style: TextStyle(
                //       color: Colors.green,
                //       fontFamily: 'CookieRun',
                //       fontWeight: FontWeight.w500),
                // ),
                InkWell(
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: ThemeColors.basic,
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
            // SizedBox(height: 10.0.h),
            const Text(
              '출석체크 완료',
              style: TextStyle(
                  color: ThemeColors.primary,
                  fontFamily: 'NanumSquareRound',
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 5.0.h),
            const TextCustom(
              text: '무화과 1개 획득',
              fontWeight: FontWeight.bold,
            ),
            Container(
              padding: EdgeInsets.all(10.h),
              child: Image.asset(
                'images/Fig2.png',
                width: 80.w,
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Container(
                width: 200.w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                    color: ThemeColors.fig_green,
                    borderRadius: BorderRadius.circular(20.0)),
                child: const TextCustom(
                  text: '내 무화과 확인하기',
                  color: ThemeColors.basic,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
