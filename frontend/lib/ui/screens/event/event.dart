import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/helpers/modal_checkLogin.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ThemeColors.third,
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text(
            '이벤트',
            style: TextStyle(
              color: ThemeColors.primary,
              fontFamily: 'CookieRun',
              fontSize: 24,
            ),
          ),
          leading: InkWell(
            onTap: () =>
                Navigator.push(context, routeSlide(page: const LoginPage())),
            child: Image.asset(
              'images/aco.png',
              height: 70,
            ),
          ),
          backgroundColor: Colors.white, //ThemeColors.primary,
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is SuccessAuthentication) {
                              return Center(
                                  child: Column(
                                children: [
                                  Image.asset(
                                    'images/aco2.png',
                                    width: 300,
                                    height: 300,
                                  ),
                                  const TextCustom(
                                      text: '준비중입니다!', fontSize: 20),
                                ],
                              ));
                            } else {
                              modalCheckLogin().showBottomDialog(context);
                              return Center(
                                  child: Column(
                                children: [
                                  Image.asset(
                                    'images/aco2.png',
                                    // width: 300,
                                    height: size.height / 3,
                                  ),
                                  const TextCustom(
                                      text: '준비중입니다!', fontSize: 20),
                                ],
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(index: 4),
      ),
    );
  }
}
