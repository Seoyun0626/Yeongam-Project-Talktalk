import 'package:flutter/material.dart';
import 'package:login/data/env/env.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/code_service.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPolicyPage extends StatefulWidget {
  const DetailPolicyPage(this.policies, {Key? key}) : super(key: key);
  final Policy policies;

  @override
  State<DetailPolicyPage> createState() => _DetailPolicyState();
}

class _DetailPolicyState extends State<DetailPolicyPage> {
  late String policyInstitution = '';
  late String policyTarget = '';
  late String policyField = '';
  late String policyCharacter = '';

  @override
  void initState() {
    final Policy policies = widget.policies;
    final String institutionCode = policies.policy_institution_code; // 기관 코드
    final String targetCode = policies.policy_target_code; // 적용 대상 코드
    final String fieldCode = policies.policy_field_code; // 분야 코드
    final String characterCode = policies.policy_character_code;

    // 수정 필요
    codeService.getCodeData().then((value) {
      setState(() {
        var institutionLen = value['codes']['policy_institution_code'].length;
        var targetLen = value['codes']['policy_target_code'].length;
        var fieldLen = value['codes']['policy_field_code'].length;
        var charLen = value['codes']['policy_character_code'].length;

        // 기관
        for (int i = 0; i < institutionLen; i++) {
          var codeDetail =
              value['codes']['policy_institution_code'][i]['code_detail'];
          if (codeDetail == institutionCode) {
            var codeDetailName = value['codes']['policy_institution_code'][i]
                ['code_detail_name'];
            policyInstitution = codeDetailName;
            // print(policyInstitution);
          }
        }

        // 대상
        for (int i = 0; i < targetLen; i++) {
          var codeDetail =
              value['codes']['policy_target_code'][i]['code_detail'];
          if (codeDetail == targetCode) {
            var codeDetailName =
                value['codes']['policy_target_code'][i]['code_detail_name'];
            policyTarget = codeDetailName;
            // print(policyInstitution);
          }
        }

        // 분야
        for (int i = 0; i < fieldLen; i++) {
          var codeDetail =
              value['codes']['policy_field_code'][i]['code_detail'];
          if (codeDetail == fieldCode) {
            var codeDetailName =
                value['codes']['policy_field_code'][i]['code_detail_name'];
            policyField = codeDetailName;
            // print(policyInstitution);
          }
        }

        // 정책 성격
        for (int i = 0; i < charLen; i++) {
          var codeDetail =
              value['codes']['policy_character_code'][i]['code_detail'];
          if (codeDetail == characterCode) {
            var codeDetailName =
                value['codes']['policy_character_code'][i]['code_detail_name'];
            policyCharacter = codeDetailName;
            // print(policyInstitution);
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Policy policies = widget.policies;
    final String imgName = policies.img;

    final String imgUrl = '${Environment.urlApiServer}/upload/policy/$imgName';

    final String policySupervison = policies.policy_institution_code;
    final String policyName = policies.policy_name;
    final String policyContent = policies.content;
    final String policyCategory = policies.policy_field_code;
    final String policyLink = policies.policy_link;

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
          backgroundColor: Colors.white,
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
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ]),
              ),
              Container(
                  // 주최측
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                  width: size,
                  color: Colors.white,
                  child: Text(policyInstitution)),
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
                      child: Text(
                        policyField,
                        // policyCategory,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
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
                        policyTarget,
                        // policies.policy_target_code,
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
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
              Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                width: size,
                color: Colors.white,
                child: BtnNaru(
                  text: '신청하기',
                  colorText: Colors.black,
                  width: size,
                  onPressed: () {
                    launchUrl(Uri.parse(policyLink));
                  },
                ),
              )
            ],
          )))),
        ));
  }
}
