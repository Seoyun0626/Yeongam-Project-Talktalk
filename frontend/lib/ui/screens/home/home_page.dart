import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/user/my_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 검색창
  final TextEditingController filter = TextEditingController(); // 검색 위젯 컨트롤
  final FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태 등
  String searchText = ""; // 현재 검색어 값

  _HomePageState() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  } // filter가 변화를 검지하여 searchText의 상태를 변화시키는 코드

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text('청소년톡talk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          leading: InkWell(
            onTap: () =>
                Navigator.push(context, routeSlide(page: const LoginPage())),
            child: Image.asset('images/aco.png', height: 70),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.perm_identity),
              onPressed: () =>
                  Navigator.push(context, routeSlide(page: const LoginPage())),
            )
          ],
          backgroundColor: ThemeColors.primary,
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(children: <Widget>[
          // 검색창
          Container(
            color: ThemeColors.primary,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(children: <Widget>[
              Expanded(
                flex: 6,
                child: TextField(
                  focusNode: focusNode,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  autofocus: true,
                  controller: filter,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                    suffixIcon: Icon(Icons.tune),
                  ),
                ),
              ),
            ]),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  const TextCustom(
                      text: 'MainPage',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Color.fromARGB(255, 93, 73, 98)),
                  const SizedBox(height: 30.0),
                  BtnNaru(
                    text: '로그아웃',
                    colorText: Colors.black,
                    width: size.width,
                    onPressed: () {
                      authBloc.add(OnLogOutEvent());
                      userBloc.add(OnLogOutUser());
                      Navigator.pushAndRemoveUntil(context,
                          routeSlide(page: const HomePage()), (_) => false);
                      // if (State is LogOut) {
                      //   Navigator.pushAndRemoveUntil(context,
                      //       routeSlide(page: const LoginPage()), (_) => false);
                      // } else if (State is SuccessAuthentication) {
                      //   userBloc.add(OnGetUserAuthenticationEvent());
                      //   Navigator.pushAndRemoveUntil(context,
                      //       routeSlide(page: const MyPage()), (_) => false);
                      // }
                    },
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
