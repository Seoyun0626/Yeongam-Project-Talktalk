import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';
// import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/intro/checking_login_page.dart';
// import 'package:login/ui/screens/home/home_page.dart';
// import 'package:login/ui/screens/policy/policy_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => AuthBloc()..add(OnCheckingLoginEvent())),
              BlocProvider(create: (_) => UserBloc()),
              BlocProvider(create: (_) => PolicyBloc()),
              // BlocProvider(create: (_) => StoryBloc()),
              // BlocProvider(create: (_) => ChatBloc()),
            ],
            child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: ' 영암군 청소년 복지 정책 제공',
                home: CheckingLoginPage() //HomePage(),
                ),
          );
        });
  }
}
