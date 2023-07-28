import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/domain/services/notice_services.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const TextCustom(
                text: '공지사항',
                color: ThemeColors.basic,
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
                Container(
                  // padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
                    title: TextCustom(
                      text:
                          '청소년 톡talk 서비스 점검 일정 안내드려요.(07월 19일 수요일 00:00 ~ 01:00)',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: const TextCustom(
                      text: '2023.05.12', // 현재 날짜를 표시
                      fontSize: 12,
                      color: ThemeColors.basic,
                      height: 3,
                    ),
                    onTap: () {
                      noticeService.getNoticeData();
                    },
                  ),
                )
              ]),
            )));
  }
}
