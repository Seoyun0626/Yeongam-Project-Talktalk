import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/domain/blocs/user/user_bloc.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class MyFigHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final myFigCount = userBloc.state.user?.fig ?? '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.primary),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                    left: 20.h,
                    top: 20.h,
                  ),
                  child: const TextCustom(
                      text: "무화과 지급내역",
                      fontSize: 30,
                      color: ThemeColors.basic,
                      fontWeight: FontWeight.w700)),
              Container(
                margin: EdgeInsets.all(15.h),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  height: 82.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.third,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('images/Fig.svg'),
                      TextCustom(
                          text: '$myFigCount개',
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                          color: ThemeColors.basic),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.r),
              const _FigHistory(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FigHistory extends StatefulWidget {
  const _FigHistory({Key? key}) : super(key: key);

  @override
  State<_FigHistory> createState() => _FigHistoryState();
}

class _FigHistoryState extends State<_FigHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final List<String> _tabs = ['지급 내역', '사용 내역'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // _tabs.length
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        TabBar(
            controller: _tabController,
            labelColor: ThemeColors.basic,
            unselectedLabelColor: Colors.grey,
            indicatorColor: ThemeColors.primary,
            tabs: // _tabs.map((tab) => Tab(text: tab)).toList(),
                const <Widget>[
              Tab(
                child: TextCustom(
                  text: '지급 내역',
                  fontSize: 20,
                ),
              ),
              Tab(
                child: TextCustom(
                  text: '사용 내역',
                  fontSize: 20,
                ),
              ),
            ]),
        SizedBox(
            height: MediaQuery.of(context).size.height - 200, // 높이 임시 지정
            child: TabBarView(controller: _tabController, children: [
              _buildPaymentList(),
              _buildUsageList(),
            ]))
      ]),
    );
  }

  Widget _buildPaymentList() {
    return SizedBox(
        height: 410.h,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(238, 238, 238, 1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16.w, top: 26.h, bottom: 16.h),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextCustom(
                                text: "출석 체크",
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            SizedBox(height: 8.h),
                            const TextCustom(
                              text: "2023.03.24 13:44",
                              fontSize: 15,
                            )
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset('images/Fig.svg',
                            width: 20.w, height: 20.h),
                        SizedBox(width: 6.w),
                        Container(
                            margin: EdgeInsets.only(right: 16.w),
                            child: TextCustom(
                                text: "500",
                                fontSize: 15.sp,
                                color: Colors.black))
                      ],
                    ),
                  ));
            }));
  }

  Widget _buildUsageList() {
    return SizedBox(
        height: 410.h,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(238, 238, 238, 1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16.w, top: 26.h, bottom: 16.h),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextCustom(
                                text: "출석 체크",
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            SizedBox(height: 8.h),
                            const TextCustom(
                              text: "2023.03.24 13:44",
                              fontSize: 15,
                            )
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset('images/Fig.svg',
                            width: 20.w, height: 20.h),
                        SizedBox(width: 6.w),
                        Container(
                            margin: EdgeInsets.only(right: 16.w),
                            child: TextCustom(
                                text: "500",
                                fontSize: 15.sp,
                                color: Colors.black))
                      ],
                    ),
                  ));
            }));
    ;
  }
}
