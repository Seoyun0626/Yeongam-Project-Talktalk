import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class InviteEventPage extends StatefulWidget {
  const InviteEventPage({Key? key}) : super(key: key);

  @override
  State<InviteEventPage> createState() => _InviteEventPageState();
}

class _InviteEventPageState extends State<InviteEventPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(255, 227, 91, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 227, 91, 1),
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "친구 초대 이벤트",
                  style: TextStyle(
                      fontFamily: "CookieRun",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextCustom(
                    text: "친구와 함께 무화과를 받아요",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/jara1.png',
                      height: 140.h,
                    ),
                    Image.asset(
                      'images/jara2.png',
                      height: 140.h,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                TextCustom(
                  text: "친구가 나의 초대코드를 입력하면\n모두에게 무화과 지급!",
                  maxLines: 2,
                  height: 1.3.h,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Container(
                  // height: MediaQuery.of(context).size.height.h / 1.90.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 21.w, top: 27.h),
                        child: TextCustom(
                          text: "나의 초대코드",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 60.h,
                        margin:
                            EdgeInsets.only(left: 23.w, top: 12.h, right: 23.w),
                        child: Container(
                          // height: 60.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Color.fromRGBO(247, 248, 250, 1),
                          ),
                          child: Center(child: Text("ddd")),
                        ),
                      ),
                      Container(
                        height: 58.h,
                        margin:
                            EdgeInsets.only(left: 23.w, top: 12.h, right: 23.w),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 227, 91, 1),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: TextCustom(
                              text: "카카오톡으로 초대하기",
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Center(
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 248, 250, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 23.w, top: 12.h, right: 23.w),
                        child: TextCustom(
                            text: "유의사항",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
