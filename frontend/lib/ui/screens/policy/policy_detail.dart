import 'package:flutter/material.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailPolicyPage extends StatelessWidget {
  const DetailPolicyPage(this.policies, {Key? key}) : super(key: key);
  final Policy policies;

  @override
  Widget build(BuildContext context) {
    final String imgName = policies.img;
    final String imgUrl = "images/policy/$imgName";
    final String policySupervison = policies.policy_institution_code;
    final String policyName = policies.policy_name;
    final String policyContent = policies.content;

    //모집기간
    final String startDateYear =
        policies.application_start_date.substring(0, 4);
    final String endDateYear = policies.application_end_date.substring(0, 4);
    final String startDateMonth =
        policies.application_start_date.substring(5, 7);
    final String endDateMonth = policies.application_end_date.substring(5, 7);
    final String startDateDay =
        policies.application_start_date.substring(8, 10);
    final String endDateDay = policies.application_end_date.substring(8, 10);
    final String startDate = '$startDateYear.$startDateMonth.$startDateDay';
    final String endDate = '$endDateYear.$endDateMonth.$endDateDay';

    final size = MediaQuery.of(context).size.width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                  child: Text(policySupervison)),
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
              Container(
                // 카테고리
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                width: size,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColors.secondary,
                      ),
                      child: const Text(
                        '카테고리',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  // 모집대상
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  width: size,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text(
                        '모집대상',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: size / 20,
                      ),
                      Text(
                        policies.policy_institution_code,
                        style: const TextStyle(
                          color: ThemeColors.basic,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )),
              Container(
                  // 모집기간
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  width: size,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text(
                        '모집기간',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: size / 20,
                      ),
                      Text(
                        '$startDate ~ $endDate', //'관내 초등학생',
                        style: const TextStyle(
                          color: ThemeColors.basic,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )),
              Container(
                // 상세내용
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                width: size,
                color: Colors.white,
                child: Html(
                  data: policyContent,
                  style: {
                    'p': Style(
                        color: Colors.black,
                        fontSize: FontSize.large,
                        lineHeight: LineHeight.percent(120)),
                  },
                ),
              ),
            ],
          )))),
        ));
  }
}
