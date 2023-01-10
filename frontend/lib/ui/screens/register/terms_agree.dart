import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/register//info_first.dart';
import 'package:login/ui/screens/register/user_type.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import 'package:login/ui/helpers/animation_route.dart';

class termsAgreePage extends StatefulWidget {
  //const termsAgreePage({Key? key}) : super(key: key);
  final Todo todo;
  // 생성자는 Todo를 인자로 받습니다.
  const termsAgreePage({Key? key, required this.todo}) : super(key: key);

  @override
  State<termsAgreePage> createState() => _termsAgreePageState();
}

class _termsAgreePageState extends State<termsAgreePage> {
  var _allChecked = false;
  var _isChecked1 = false;
  var _isChecked2 = false;
  var _isChecked3 = false;
  void _doSomething() {}

  @override
  Widget build(BuildContext context) {
    print(widget.todo.title);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        // title: const Text("약관 동의"),
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TextCustom(
                text: '약관동의',
                letterSpacing: 2.0,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  Material(
                    child: Checkbox(
                      activeColor: ThemeColors.primary,
                      value: _allChecked,
                      onChanged: (value) {
                        setState(() {
                          _allChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                  const TextCustom(
                    text: '약관 전체동의',
                    letterSpacing: 2.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              Container(
                height: 1.0,
                width: 500.0,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Material(
                    child: Checkbox(
                      activeColor: ThemeColors.primary,
                      value: _isChecked1,
                      onChanged: (value) {
                        setState(() {
                          _isChecked1 = value ?? false;
                        });
                      },
                    ),
                  ),
                  const TextCustom(
                    text: '(필수) ',
                    letterSpacing: 2.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const TextCustom(
                    text: '이용약관 동의',
                    letterSpacing: 2.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const RegisterPage1())),
                child: const TextCustom(
                  text: '동의하고 계속하기',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
