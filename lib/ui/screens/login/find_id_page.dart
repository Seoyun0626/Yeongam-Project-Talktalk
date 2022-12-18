import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';


class FindIDPage extends StatefulWidget {
  const FindIDPage({Key? key}) : super(key: key);

  @override
  State<FindIDPage> createState() => _FindIDPageState();
}

class _FindIDPageState extends State<FindIDPage> {

  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.clear();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const TextCustom(
                    text: '아이디 찾기',
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: ThemeColors.secondary
                ),

                const SizedBox(height: 10.0),
                const TextCustom(
                  text: '아이디를 찾으려면 이메일을 입력해주세요',
                  fontSize: 17,
                  letterSpacing: 1.0,
                  maxLines: 2,
                ),

                SizedBox(
                  height: 300,
                  width: size.width,
                  // child: SvgPicture.asset('assets/svg/undraw_forgot_password.svg'),
                ),

                const SizedBox(height: 10.0),
                TextFieldNaru(
                  controller: emailController,
                  hintText: '이메일',
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 40.0),
                BtnNaru(
                  text: '아이디 찾기',
                  width: size.width,
                  onPressed: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}