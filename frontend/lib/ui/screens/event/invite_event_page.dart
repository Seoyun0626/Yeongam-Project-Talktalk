// import 'package:flutter_kakao_sdk/flutter_kakao_sdk.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class InviteEventPage extends StatefulWidget {
  const InviteEventPage({Key? key}) : super(key: key);

  @override
  State<InviteEventPage> createState() => _InviteEventPageState();
}

class _InviteEventPageState extends State<InviteEventPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 227, 91, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 227, 91, 1),
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
          physics:
              const ClampingScrollPhysics(), //const BouncingScrollPhysics(),
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
                  padding: const EdgeInsets.only(),
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
                      Neumorphic(
                          margin: EdgeInsets.only(
                              left: 20.w, top: 10.h, right: 20.w, bottom: 40.h),
                          style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              depth: -2,
                              color: Color.fromRGBO(247, 248, 250, 1)),
                          child: Container(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              height: 60.h,
                              child: const Center(
                                  child: TextCustom(text: "ddd")))),

                      SizedBox(
                        height: 50.h,
                        width: size.width,
                        child: NeumorphicButton(
                            margin: EdgeInsets.only(left: 20.w, right: 20.w),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(50.r)),
                                depth: 2,
                                lightSource: LightSource.topLeft,
                                color: ThemeColors.secondary),
                            onPressed: () {},
                            child: Center(
                              child: TextCustom(
                                text: "카카오톡으로 초대하기",
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),

                      // BtnNaru(
                      //   margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      //   backgroundColor: ThemeColors.secondary,
                      //   height: 50.h,
                      //   text: "ㅊ",
                      //   width: size.width,
                      //   colorText: Colors.black,
                      //   fontWeight: FontWeight.bold,
                      //   onPressed: () {},
                      // ),

                      // ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Center(
                        child: Container(
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(247, 248, 250, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20.w, top: 15.h, right: 20.w),
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
