import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/policy/policy_detail.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';
import 'package:login/ui/screens/policy/policy_list.dart';

class PolicyListPage extends StatefulWidget {
  const PolicyListPage({Key? key}) : super(key: key);

  @override
  State<PolicyListPage> createState() => _PolicyListPageState();
}

class _PolicyListPageState extends State<PolicyListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PolicyBloc, PolicyState>(
        listener: (context, state) {
          if (state is LoadingPolicy) {
            modalLoadingShort(context);
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: ThemeColors.primary,
                toolbarHeight: 10,
                elevation: 0,
              ),
              // appBar: AppBar(
              //   titleSpacing: 0,
              //   title: const Text('청소년톡talk',
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 20,
              //         fontWeight: FontWeight.w600,
              //       )),
              //   leading: InkWell(
              //     onTap: () => Navigator.push(
              //         context, routeSlide(page: const LoginPage())),
              //     child: Image.asset('images/aco.png', height: 70),
              //   ),
              //   actions: [
              //     IconButton(
              //       icon: const Icon(
              //         Icons.perm_identity,
              //         size: 30,
              //         color: ThemeColors.basic,
              //       ),
              //       onPressed: () => Navigator.push(
              //           context, routeSlide(page: const LoginPage())),
              //     )
              //   ],
              //   backgroundColor: ThemeColors.primary,
              //   centerTitle: false,
              //   elevation: 0.0,
              // ),
              body: SafeArea(
                child: Column(
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
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          FutureBuilder<List<Policy>>(
                            future: policyService.getAllPolicy(),
                            builder: (_, snapshot) {
                              if (snapshot.data != null &&
                                  snapshot.data!.isEmpty) {
                                return _ListWithoutPolicy();
                              }

                              return !snapshot.hasData
                                  ? Column(
                                      children: const [
                                        ShimmerNaru(),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        ShimmerNaru(),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        ShimmerNaru(),
                                      ],
                                    )
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (_, i) => _ListViewPolicy(
                                          policies: snapshot.data![i]));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: const BottomNavigation(index: 2)),
        ));
  }
}

// 검색창
class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  final TextEditingController _filter = TextEditingController(); // 검색 위젯 컨트롤
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  String _searchText = ""; // 현재 검색어 값

  _SearchBar() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  } // filter가 변화를 검지하여 searchText의 상태를 변화시키는 코드

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.primary,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(children: <Widget>[
        Expanded(
          flex: 6,
          child: TextField(
            focusNode: myFocusNode,
            cursorColor: ThemeColors.darkGreen,
            style: const TextStyle(
              fontSize: 15,
            ),
            autofocus: false,
            controller: _filter,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(
                Icons.search,
                color: ThemeColors.darkGreen,
                size: 20,
              ),
              suffixIcon: myFocusNode.hasFocus
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        size: 20,
                        color: ThemeColors.darkGreen,
                      ),
                      onPressed: () {
                        setState(() {
                          _filter.clear();
                          _searchText = "";
                          myFocusNode.unfocus();
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.tune,
                        color: ThemeColors.darkGreen,
                        size: 20,
                      ),
                      onPressed: (() {})),
              hintText: '복지 검색',
              labelStyle: const TextStyle(color: ThemeColors.darkGreen),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ]),
    );
  }
}

// 정책 리스트
class _ListViewPolicy extends StatelessWidget {
  final Policy policies;

  const _ListViewPolicy({Key? key, required this.policies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final policyBloc = BlocProvider.of<PolicyBloc>(context);
    final String imgName = policies.img;
    final String imgUrl = "images/policy/$imgName";

    // 모집 기간
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

    return Padding(
        padding: const EdgeInsets.fromLTRB(3, 3, 3, 0), // 카드 바깥쪽
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(7), // 카드 안쪽
              child: InkWell(
                  splashColor: ThemeColors.primary.withAlpha(30),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPolicyPage(policies),
                        ),
                      ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: SizedBox(
                            // 이미지
                            width: 80.0,
                            height: 80.0,
                            child: Image(
                              image: AssetImage(imgUrl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      policies.policy_institution_code,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: ThemeColors.basic),
                                    ), // 주최측
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      policies.policy_name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ), // 정책 제목
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ThemeColors.secondary,
                                      ),
                                      child: Text(
                                        '$startDate ~ $endDate',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ) // 모집 기간
                                  ],
                                ))),
                        SizedBox(
                          // decoration: BoxDecoration(color: Colors.grey[350]),
                          width: 80.0,
                          height: 80.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.bookmark_border,
                                  size: 30,
                                  color: ThemeColors.basic,
                                ),
                                onPressed: () {},
                              ),
                              const Text('0',
                                  style: TextStyle(
                                      color: ThemeColors.basic, fontSize: 10))
                            ],
                          ),
                        ),
                      ]))),
        ));
  }
}

class _ListWithoutPolicy extends StatelessWidget {
  // final List<String> svgPosts = [
  //   'assets/svg/without-posts-home.svg',
  //   'assets/svg/without-posts-home.svg',
  //   'assets/svg/mobile-new-posts.svg',
  // ];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        TextCustom(text: "등록된 정책이 없습니다."),
      ],
      // children: List.generate(3, (index) => Container(
      //     margin: const EdgeInsets.only(bottom: 20.0),
      //     padding: const EdgeInsets.all(10.0),
      //     height: 350,
      //     width: size.width,
      //     // color: Colors.amber,
      //     child: SvgPicture.asset(svgPosts[index], height: 15),
      //   ),
      // ),
    );
  }
}
