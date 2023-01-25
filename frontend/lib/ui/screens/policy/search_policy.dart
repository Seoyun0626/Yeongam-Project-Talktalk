import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/blocs/policy/policy_bloc.dart';

class SearchPolicyPage extends StatefulWidget {
  const SearchPolicyPage({Key? key}) : super(key: key);

  @override
  State<SearchPolicyPage> createState() => _SearchPolicyPageState();
}

class _SearchPolicyPageState extends State<SearchPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PolicyBloc, PolicyState>(
        listener: (context, state) {
          if (state is LoadingPolicy) {
            modalLoadingShort(context);
          }
        },
        child: MaterialApp(
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
              body: SafeArea(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    FutureBuilder<List<Policy>>(
                      future: policyService.getAllPolicy(),
                      builder: (_, snapshot) {
                        if (snapshot.data != null && snapshot.data!.isEmpty) {
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, i) => _ListViewPolicy(
                                    policies: snapshot.data![i]));
                      },
                    )
                  ],
                ),
              ),
              // body: Column(
              //   children: <Widget>[
              //     const SearchBar(),
              //     Container(
              //       color: Colors.white,
              //       height: 43,
              //       padding: const EdgeInsets.all(13),
              //       child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: const [
              //             TextCustom(
              //               text: "검색결과",
              //               color: ThemeColors.basic,
              //               fontSize: 15.0,
              //             ),
              //             Icon(
              //               Icons.arrow_drop_down_circle_outlined,
              //               color: ThemeColors.basic,
              //             ),
              //           ]),
              //     ),
              //     ListView(shrinkWrap: true, children: const <Widget>[
              //       // Card(
              //       //   child: ListTile(
              //       //     leading: FlutterLogo(size: 72.0),
              //       //     title: Text('Three-line ListTile'),
              //       //     subtitle: Text(
              //       //         'A sufficiently long subtitle warrants three lines.'),
              //       //     trailing: Icon(Icons.more_vert),
              //       //     isThreeLine: true,
              //       //   ),
              //       // ),
              //       CustomListItem(
              //         thumbnail: Icon(
              //           Icons.abc,
              //           size: 72.0,
              //         ),
              //         policy_organizer: '영암군청소년수련관',
              //         policy_name: '2022년 3차 청소년문화의집 모집 안내',
              //       ),

              //     ])
              //   ],
              // ),
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
  });

  final String policy_organizer;
  final String policy_name;

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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.0, color: ThemeColors.basic),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              policy_name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        )),
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
  });

  final Widget thumbnail;
  final String policy_organizer;
  final String policy_name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5), //symmetric(vertical: 10.0),
        child: SizedBox(
          height: 100,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.2,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ]),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// 정책 리스트 22
class _ListViewPolicy extends StatelessWidget {
  final Policy policies;

  const _ListViewPolicy({Key? key, required this.policies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final policyBloc = BlocProvider.of<PolicyBloc>(context);

    // final List<String> listImages = policies.images.split(',');
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.2,
                blurRadius: 2,
                offset: const Offset(0, 2),
              )
            ]),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AspectRatio(
                aspectRatio: 1.0,
                child: Icon(
                  Icons.stars_outlined,
                  size: 72.0,
                  color: Colors.amber,
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          policies.policy_organizer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12.0, color: ThemeColors.basic),
                        ), // 주최측
                        Text(
                          policies.policy_name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ), // 정책 제목
                      ],
                    )),
              )
            ]),
      ),
    );
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
    final size = MediaQuery.of(context).size;

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
