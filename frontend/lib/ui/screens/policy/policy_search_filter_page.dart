import 'package:flutter/material.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/policy/policy_list_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class PolicySearchFilterPage extends StatefulWidget {
  const PolicySearchFilterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PolicySearchFilterPage> createState() => _PolicySearchFilterState();
}

class _PolicySearchFilterState extends State<PolicySearchFilterPage> {
  late CodeDetailData selectedCode;

  void setSelectedCodeData(CodeDetailData data) {
    setState(() {
      selectedCode = data;
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
            color: ThemeColors.basic,
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
              SearchConditionList(
                  title: '운영 기관',
                  codeName: 'policy_institution_code',
                  setSelectedCodeData: (data) {
                    setSelectedCodeData(data);
                  }),
              const SizedBox(
                height: 20,
              ),
              // SearchConditionList(
              //     title: '적용 대상',
              //     codeName: 'policy_target_code',
              //     setSelectedCodeData: (data) {
              //       setSelectedCodeData(data);
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              // SearchConditionList(
              //     title: '정책 분야',
              //     codeName: 'policy_field_code',
              //     setSelectedCodeData: (data) {
              //       setSelectedCodeData(data);
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              // SearchConditionList(
              //     title: '정책 성격',
              //     codeName: 'policy_character_code',
              //     setSelectedCodeData: (data) {
              //       setSelectedCodeData(data);
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              // SearchConditionList(
              //     title: '지역',
              //     codeName: 'emd_class_code',
              //     setSelectedCodeData: (data) {
              //       setSelectedCodeData(data);
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              Center(
                  child: BtnNaru(
                text: '검색하기',
                onPressed: () {
                  // print(selectedCode.code);
                  // print(selectedCode.detailName);
                  // print(selectedCode.codeName);

                  Navigator.pop(context, {
                    'codeDetail': selectedCode.code,
                    'codeName': selectedCode.codeName,
                  });

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PolicyListPage(
                                codeDetail: selectedCode.code,
                                codeName: selectedCode.codeName,
                              )),
                      (_) => false);

                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     routeFade(
                  //         page: PolicyListPage(
                  //       codeDetail: selectedCode.code,
                  //       codeName: selectedCode.codeName,
                  //     )),
                  //     (_) => false);
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
  final void Function(CodeDetailData) setSelectedCodeData;

  const SearchConditionList({
    Key? key,
    required this.title,
    required this.codeName,
    required this.setSelectedCodeData, //콜백 함수 전달
  }) : super(key: key);

  @override
  State<SearchConditionList> createState() => _SearchConditionListState();
}

class _SearchConditionListState extends State<SearchConditionList> {
  List<CodeDetailData> codeDetailDataList = [];
  int selectedIndex = -1;
  CodeDetailData? _selectedCode;

  void _onSelected(CodeDetailData data) {
    setState(() {
      _selectedCode = data;
    });
    widget.setSelectedCodeData(data);
  }

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
                  final codeDetailData = codeDetailDataList[index];
                  setState(() {
                    // codeDetailData.selected = !codeDetailData.selected;
                    _onSelected(codeDetailData);
                    if (selectedIndex != index) {
                      if (selectedIndex != -1) {
                        codeDetailDataList[selectedIndex].selected = false;
                      }
                      codeDetailData.selected = true;
                      selectedIndex = index;
                      _selectedCode = codeDetailData;
                    } else {
                      codeDetailData.selected = false;
                      selectedIndex = -1;
                      _selectedCode = null;
                    }
                    // if (selectedCodeData == codeDetailData) {
                    //   selectedCodeData = null; // 선택 취소
                    // } else {
                    //   selectedCodeData = codeDetailData; // 선택
                    // }
                    // print(_selectedCode?.code);
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
                      text: codeDetailData.detailName,
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
}
