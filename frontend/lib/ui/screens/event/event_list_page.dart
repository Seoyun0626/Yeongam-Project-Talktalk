import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/domain/blocs/auth/auth_bloc.dart';
import 'package:login/ui/helpers/attendance_event_controller.dart';
import 'package:login/ui/helpers/modals/modal_checkLogin.dart';
import 'package:login/ui/screens/event/attendance_event_page.dart';
import 'package:login/ui/screens/event/invite_event_page.dart';
import 'package:login/ui/screens/event/weeklyFig_event_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;

    List<String> bannerIconList = [
      'images/event_icon/attendance_icon.svg',
      'images/event_icon/flagIcon.svg',
      'images/event_icon/invite_icon.svg'
    ];
    List<Color> bannerColorsList = [
      ThemeColors.primary,
      Color.fromRGBO(251, 238, 231, 1),
      Color.fromRGBO(255, 227, 91, 1)
    ];
    List<Color> bannerIconsColorsList = [
      Colors.white,
      ThemeColors.primary,
      Color.fromRGBO(53, 29, 31, 1)
    ];
    List<String> bannerTitleList = [
      '하루 한 번, 출석 체크하고 무화과 받기',
      '매주 챌린지 참여하고 무화과 받기',
      '친구 초대하고 함께 무화과 받기'
    ];
    List<String> bannerDateList = [
      '2021.07.01 ~ 2023.07.31',
      '2021.07.01 ~ 2023.07.31',
      '2021.07.01 ~ 2023.07.31'
    ];

    // EventController controller = EventController();
    // controller.onInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextCustom(
            text: "무화과 이벤트",
            fontSize: 20.sp,
            color: Color.fromRGBO(88, 88, 86, 1),
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ThemeColors.primary,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: 800.h,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 24.w, right: 24.w, top: 20.h, bottom: 8.h),
                    child: InkWell(
                      onTap: () {
                        if (index == 0) {
                          if (authState is LogOut) {
                            modalCheckLogin(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendanceEventPage(),
                                ));
                          }
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WeeklyFigEventPage(),
                              ));
                        } else if (index == 2) {
                          if (authState is LogOut) {
                            modalCheckLogin(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InviteEventPage(),
                                ));
                          }
                        }
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: bannerColorsList[index],
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(bannerIconList[index],
                                      color: bannerIconsColorsList[index])),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            TextCustom(
                                text: bannerTitleList[index],
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              height: 4.h,
                            ),
                            TextCustom(
                              text: bannerDateList[index],
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
