import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';

class DetailPolicyPage extends StatelessWidget {
  const DetailPolicyPage(this.policies, {Key? key}) : super(key: key);
  final Policy policies;

  @override
  Widget build(BuildContext context) {
    final String imgName = policies.img;
    final String imgUrl = "images/policy/$imgName";
    final String policySupervison = policies.policy_supervision;
    final String policyName = policies.policy_name;

    final size = MediaQuery.of(context).size.width;

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ThemeColors.basic,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            width: size,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(children: [
              SizedBox(
                width: size / 1.5,
                child: Image(
                  image: AssetImage(imgUrl),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ]),
          ),
          Container(
            // 주최측
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
            width: size,
            color: Colors.white,
            child: const Text('영암군청소년수련관'), //Text(policySupervison)
          ),
          Container(
              // 정책 이름
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              width: size,
              color: Colors.white,
              child: Text(
                policyName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
        ],
      )))),
    ));
  }
}
