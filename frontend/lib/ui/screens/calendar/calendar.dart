import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text('캘린더',
                style: TextStyle(
                  color: ThemeColors.basic,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            leading: InkWell(
              onTap: () =>
                  Navigator.push(context, routeSlide(page: const LoginPage())),
              child: Image.asset(
                'images/aco.png',
                height: 70,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.perm_identity,
                  size: 30,
                  color: ThemeColors.basic,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    )),
                // onPressed: () => Navigator.push(
                //   context, routeSlide(page: const LoginPage())),

                // }
              )
            ],
            backgroundColor: ThemeColors.primary,
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Column(children: <Widget>[
            Expanded(
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(50),
                          child: const Text('아직 준비중입니다!',
                              style: TextStyle(fontSize: 30)))
                    ],
                  ),
                ),
              ]),
            )
          ]),
          bottomNavigationBar: const BottomNavigation(index: 4),
        ));
  }
}
