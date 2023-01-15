import 'package:flutter/material.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class SearchPolicyPage extends StatefulWidget {
  const SearchPolicyPage({Key? key}) : super(key: key);

  @override
  State<SearchPolicyPage> createState() => _SearchPolicyPageState();
}

class _SearchPolicyPageState extends State<SearchPolicyPage> {
  final TextEditingController filter = TextEditingController(); // 검색 위젯 컨트롤
  final FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태 등
  String searchText = ""; // 현재 검색어 값

  _SearchPolicyPageState() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  } // filter가 변화를 검지하여 searchText의 상태를 변화시키는 코드

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const LoginPage())),
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
            )
          ])),
    );
  }
}
