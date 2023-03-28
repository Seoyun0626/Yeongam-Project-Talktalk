import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';

class CodeDetailData {
  final String? name;
  final String? code;
  CodeDetailData({this.name, this.code});
}

class CodeData {
  final String? detailName;
  final List<CodeDetailData>? detailList;
  CodeData({this.detailName, this.detailList});
}

class PolicySearchFilterPage extends StatelessWidget {
  PolicySearchFilterPage({Key? key}) : super(key: key);

  List<CodeDetailData> institutionList = [
    CodeDetailData(name: '영암군', code: '00'),
    CodeDetailData(name: '청소년 수련관', code: '01'),
    CodeDetailData(name: '방과후 아카데미', code: '02'),
    CodeDetailData(name: '청소년상담복지센터', code: '03'),
    CodeDetailData(name: '학교밖지원센터', code: '03'),
    CodeDetailData(name: '삼호읍청소년문화의집', code: '05'),
  ];

  List<CodeDetailData> targetList = [
    CodeDetailData(name: '부부/임산부', code: '00'),
    CodeDetailData(name: '영유아', code: '01'),
    CodeDetailData(name: '청소년/대학생', code: '02'),
    CodeDetailData(name: '청년/대학생', code: '03'),
    CodeDetailData(name: '직장인', code: '03'),
    CodeDetailData(name: '노인', code: '05'),
  ];

  // List<CodeData> totalList = [
  //   CodeData(detailName: '기관', detailList: institutionList),
  // ];

  @override
  Widget build(BuildContext context) {
    List<CodeDetailData>? selectedInstitutionList = [];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              titleSpacing: 0,
              title: const Text('검색조건',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )),
              leading: IconButton(
                icon: const Icon(Icons.close, color: ThemeColors.basic),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.white,
              centerTitle: false,
              elevation: 0.0),
          body: FilterListWidget<CodeDetailData>(
            hideSelectedTextCount: true,
            hideSearchField: true,
            applyButtonText: '검색하기',
            resetButtonText: '초기화',
            listData: institutionList,
            selectedListData: selectedInstitutionList,

            enableOnlySingleSelection: true, // 단수 선택
            onApplyButtonClick: ((list) {
              selectedInstitutionList = List.from(list!);
              Navigator.pop(context);
              if (list != null) {
                print("Selected items count: ${list.length}");
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const PolicyListPage(), // 복지검색 탭
              //     ));
            }),
            choiceChipLabel: (item) {
              return item!.name;
            },
            validateSelectedItem: (list, value) {
              return list!.contains(value);
            },
            onItemSearch: ((item, query) {
              return item.name!.toLowerCase().contains(query.toLowerCase());
            }),
          ),

          // 팝업창
          // void openFilterDialog() async {
          //   await FilterListDialog.display(
          //     context,
          //     listData: institutionList,
          //     selectedListData: selectedInstitutionList,
          //     choiceChipLabel: (institution) => institution!.name,
          //     height: 480,
          //     headlineText: "카테고리 선택",
          //     validateSelectedItem: (list, value) => list!.contains(value),
          //     onItemSearch: (institution, query) {
          //       return institution.name!.toLowerCase().contains(query);
          //     },
          //     onApplyButtonClick: (list) {
          //       selectedInstitutionList = List.from(list!);
          //     },
          //   );
          // }
          // 팝업창
          // return Scaffold(
          //   floatingActionButton: FloatingActionButton(
          //     onPressed: openFilterDialog,
          //     child: const Icon(Icons.add),
          //   ),
          //   body: selectedInstitutionList == null || selectedInstitutionList!.isEmpty
          //       ? const Center(child: Text('No user selected'))
          //       : ListView.builder(
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(selectedInstitutionList![index].name!),
          //             );
          //           },
          //           itemCount: selectedInstitutionList!.length,
          //         ),
          // );
        ));
  }
}
