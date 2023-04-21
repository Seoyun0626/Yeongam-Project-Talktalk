import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/policy/policy_list.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';

class PolicySearchFilterPage extends StatefulWidget {
  const PolicySearchFilterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PolicySearchFilterPage> createState() => _PolicySearchFilterState();
}

class _PolicySearchFilterState extends State<PolicySearchFilterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TextCustom(
            text: '상세 검색 조건',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchConditionList(
                title: '운영 기관',
                codeName: 'policy_institution_code',
              ),
              const SizedBox(
                height: 20,
              ),
              const SearchConditionList(
                title: '적용 대상',
                codeName: 'policy_target_code',
              ),
              const SizedBox(
                height: 20,
              ),
              const SearchConditionList(
                title: '정책 분야',
                codeName: 'policy_field_code',
              ),
              const SizedBox(
                height: 20,
              ),
              const SearchConditionList(
                title: '정책 성격',
                codeName: 'policy_character_code',
              ),
              const SizedBox(
                height: 20,
              ),
              const SearchConditionList(
                title: '지역',
                codeName: 'emd_class_code',
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: BtnNaru(
                text: '검색하기',
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     routeSlide(
                  //         page: const PolicyListPage(
                  //       codeName: '',
                  //       codeDetail: '',
                  //     )),
                  //     (_) => false);
                  // Navigator.pop(
                  //   context,
                  //   {
                  //     'codeName': '',
                  //     'codeDetail': ' ',
                  //   },
                  // );
                },
                width: size.width - 30,
                colorText: Colors.black,
                backgroundColor: ThemeColors.secondary,
                border: 10,
              ))
            ],
          ),
        )),
      ),
    );
  }
}

class SearchConditionList extends StatefulWidget {
  final String title;
  final String codeName;
  // final Function(List<CodeDetailData>) onSelectionChanged;

  const SearchConditionList({
    Key? key,
    required this.title,
    required this.codeName,
    // required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<SearchConditionList> createState() => _SearchConditionListState();
}

class _SearchConditionListState extends State<SearchConditionList> {
  List<CodeDetailData> codeDetailDataList = [];
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    codeDetailDataList =
        getMobileCodeService.getCodeDetailList(widget.codeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String title = widget.title;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
          child: Text(
            title,
            style: const TextStyle(
                color: ThemeColors.basic,
                fontFamily: 'NanumSquareRound',
                fontWeight: FontWeight.w600,
                fontSize: 20),
          )),
      Center(
          child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ...List.generate(
            codeDetailDataList.length,
            (index) {
              final codeDetailData = codeDetailDataList[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    // codeDetailData.selected = !codeDetailData.selected;
                    if (selectedIndex != index) {
                      if (selectedIndex != -1) {
                        codeDetailDataList[selectedIndex].selected = false;
                      }
                      codeDetailData.selected = true;
                      selectedIndex = index;
                    } else {
                      codeDetailData.selected = false;
                      selectedIndex = -1;
                    }
                  });
                },
                child: Container(
                  width: (size.width / 2) - 30,
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: codeDetailData.selected == true
                        ? ThemeColors.secondary
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextCustom(
                      text: codeDetailData.name!,
                      color: codeDetailData.selected == true
                          ? Colors.black
                          : ThemeColors.basic,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ))
    ]);
  }

  List<CodeDetailData> getSelectedItems() {
    return codeDetailDataList.where((item) => item.selected).toList();
  }
}
