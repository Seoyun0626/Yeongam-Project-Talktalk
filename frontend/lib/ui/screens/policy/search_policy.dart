import 'package:flutter/material.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class SearchPolicyPage extends StatefulWidget {
  const SearchPolicyPage({Key? key}) : super(key: key);

  @override
  State<SearchPolicyPage> createState() => _SearchPolicyPageState();
}

class _SearchPolicyPageState extends State<SearchPolicyPage> {
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
                    fontWeight: FontWeight.w600,
                  )),
              leading: InkWell(
                onTap: () => Navigator.push(
                    context, routeSlide(page: const LoginPage())),
                child: Image.asset('images/aco.png', height: 70),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.perm_identity,
                    size: 30,
                    color: ThemeColors.basic,
                  ),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const LoginPage())),
                )
              ],
              backgroundColor: ThemeColors.primary,
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Column(
              children: <Widget>[
                const SearchBar(),
                Container(
                  color: Colors.white,
                  height: 43,
                  padding: const EdgeInsets.all(13),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        TextCustom(
                          text: "검색결과",
                          color: ThemeColors.basic,
                          fontSize: 15.0,
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: ThemeColors.basic,
                        ),
                      ]),
                ),
                ListView(shrinkWrap: true, children: const <Widget>[
                  Card(
                    child: ListTile(
                      leading: FlutterLogo(size: 72.0),
                      title: Text('Three-line ListTile'),
                      subtitle: Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      trailing: Icon(Icons.more_vert),
                      isThreeLine: true,
                    ),
                  ),
                  CustomListItem(
                      thumbnail: Icon(
                        Icons.abc,
                        size: 72.0,
                      ),
                      policy_organizer: '영암군청소년수련관',
                      policy_name: '2022년 3차 청소년문화',
                      policy_startDate: '22.11.29',
                      policy_endDate: '22.12.01',
                      policy_category: '문화')
                ])
              ],
            )));
  }
}

// 검색창
class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  final TextEditingController filter = TextEditingController(); // 검색 위젯 컨트롤
  final FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태 등
  String searchText = ""; // 현재 검색어 값

  _SearchBar() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  } // filter가 변화를 검지하여 searchText의 상태를 변화시키는 코드

  @override
  Widget build(BuildContext context) {
    return // 검색창
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
    );
  }
}

// 정책 리스트
class _PolicyList extends StatelessWidget {
  const _PolicyList({
    required this.policy_organizer, //주최측
    required this.policy_name, // 제목
    required this.policy_startDate, // 모집 시작 날짜
    required this.policy_endDate, // 모집 마감 날짜
    required this.policy_category, // 카테고리
  });

  final String policy_organizer;
  final String policy_name;
  final String policy_startDate;
  final String policy_endDate;
  final String policy_category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              policy_organizer,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.0, color: ThemeColors.basic),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              policy_name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        )),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '$policy_startDate ~ $policy_endDate',
                  style: const TextStyle(
                      fontSize: 12.0, color: ThemeColors.darkGreen),
                ),
                Row(
                  children: const [Text('문화')],
                )
              ]),
        )
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.policy_organizer, //주최측
    required this.policy_name, // 제목
    required this.policy_startDate, // 모집 시작 날짜
    required this.policy_endDate, // 모집 마감 날짜
    required this.policy_category, // 카테고리
  });

  final Widget thumbnail;
  final String policy_organizer;
  final String policy_name;
  final String policy_startDate;
  final String policy_endDate;
  final String policy_category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _PolicyList(
                  policy_organizer: policy_organizer,
                  policy_name: policy_name,
                  policy_startDate: policy_startDate,
                  policy_endDate: policy_endDate,
                  policy_category: policy_category,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
