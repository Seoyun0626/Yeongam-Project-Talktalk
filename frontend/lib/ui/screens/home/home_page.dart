import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/env/env.dart';
import 'package:login/domain/blocs/auth/auth_bloc.dart';
import 'package:login/domain/blocs/user/user_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/code_service.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/screens/policy/policy_detail.dart';
import 'package:login/ui/screens/policy/policy_list.dart';
import 'package:login/ui/screens/policy/search_filter.dart';
import 'package:login/ui/screens/user/my_page.dart';
import 'package:login/ui/screens/user/privacy_setting_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login/domain/models/response/response_banner.dart';
import 'package:login/domain/services/banner_services.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/policy/policy_search.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/ui/screens/policy/policy_detail.dart';
import 'package:login/domain/services/policy_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text('청소년 톡Talk',
                style: TextStyle(
                  color: ThemeColors.basic,
                  fontFamily: 'CookieRun',
                  fontSize: 24,
                )),
            leading: InkWell(
              // onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const LoginPage(),
              //     )),
              child: Image.asset('images/aco.png', height: 70),
            ),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.perm_identity,
                    size: 30,
                    color: ThemeColors.basic,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const LoginPage(),
                    //     ));

                    if (authBloc.state is LogOut) {
                      // 로그인 상태일 경우 ProfilePage로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    } else {
                      // 로그인 상태가 아닐 경우 LoginPage로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyPage()),
                      );
                    }
                  }),
            ],
            backgroundColor: ThemeColors.primary,
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 배너 슬라이드
                  FutureBuilder<List<Banners>>(
                    future: bannerService.getBannerData(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          children: const [
                            ShimmerNaru(),
                          ],
                        );
                      } else {
                        return CarouselSlider.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index, realIndex) =>
                              BannerSlide(
                                  policyBanners: snapshot.data![index])),
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            height: MediaQuery.of(context).size.height / 4,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            autoPlay: true,
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                      child: Column(children: [
                        Row(children: const [
                          Icon(
                            Icons.category,
                            color: ThemeColors.darkGreen,
                            size: 25,
                          ),
                          // ImageIcon(
                          //   AssetImage("images/icon_check.png"),
                          //   color: ThemeColors.darkGreen,
                          //   size: 20,
                          // ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('카테고리별 정책을 확인하세요!',
                              style: TextStyle(
                                color: ThemeColors.basic,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              )),
                        ])
                      ])),

                  const SizedBox(
                    width: 5,
                  ),
                  // 카테고리 아이콘
                  CategoryButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  // 실시간 인기글
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PolicyListPage(
                              categoryName: '',
                              categoryValue: '',
                            ), // 복지검색 탭
                          )),
                      child: Row(children: const [
                        Icon(
                          Icons.auto_awesome,
                          color: ThemeColors.darkGreen,
                        ),
                        // Image.asset('images/icon_sparkel.png'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('지금 인기있는 정책은?',
                            style: TextStyle(
                              color: ThemeColors.basic,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            )),
                      ]),
                    ),
                  ),

                  // 실시간 인기글
                  FutureBuilder<List<Policy>>(
                      future: policyService.getAllPolicy(),
                      builder: ((_, snapshot) {
                        if (snapshot.data != null && snapshot.data!.isEmpty) {
                          return _ListWithoutPopularPolicy();
                        }
                        if (!snapshot.hasData) {
                          return const _ShimerLoadingPopularPolicy();
                        } else {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (_, i) => livePopularPost(
                                  // codeData: codeData,
                                  ranking: i,
                                  policies: snapshot.data![i]));
                        }
                      })),

                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavigation(index: 1)),
    );
  }
}

// 배너 슬라이드
class BannerSlide extends StatelessWidget {
  final Banners policyBanners;
  const BannerSlide({super.key, required this.policyBanners});

  @override
  Widget build(BuildContext context) {
    final bannerImgName = policyBanners.banner_img;

    final bannerImgUrl =
        '${Environment.urlApiServer}/upload/banner/$bannerImgName';
    final bannerLink = policyBanners.banner_link;

    return InkWell(
        onTap: () {
          launchUrl(Uri.parse(bannerLink));
        },
        child: Image.network(
          bannerImgUrl,
          fit: BoxFit.fitWidth,
        ) //Image.asset(bannerImgUrl, fit: BoxFit.fitWidth),
        );
  }
}

class Category {
  final String name;
  final String code;
  final String icon;
  Category({required this.name, required this.code, required this.icon});
}

// 카테고리 아이콘 버튼
class CategoryButton extends StatelessWidget {
  final List<Category> categoryIcons01 = [
    Category(
        name: '학업', code: '00', icon: 'images/category_icon/icon_study.png'),
    Category(
        name: '상담',
        code: '01',
        icon: 'images/category_icon/icon_counseling.png'),
    Category(
        name: '취업/이직', code: '02', icon: 'images/category_icon/icon_job.png'),
    Category(
        name: '생활비', code: '03', icon: 'images/category_icon/icon_living.png'),
  ];

  final List<Category> categoryIcons02 = [
    Category(
        name: '건강', code: '04', icon: 'images/category_icon/icon_health.png'),
    Category(
        name: '주거', code: '05', icon: 'images/category_icon/icon_house.png'),
    Category(
        name: '결혼/양육', code: '06', icon: 'images/category_icon/icon_baby.png'),
    Category(
        name: '전체보기', code: '', icon: 'images/category_icon/icon_allsee.png'),
  ];
  CategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  IconButton(
                      icon: Image.asset(
                          categoryIcons01[index].icon), //pngIcons01[index]
                      onPressed: () {
                        var codeName = categoryIcons01[index].name;
                        var codeValue = categoryIcons01[index].code;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PolicyListPage(
                                categoryName: codeName,
                                categoryValue: codeValue,
                              ), // 복지검색 탭
                            ));
                      },
                      iconSize: MediaQuery.of(context).size.width / 8),
                  Text(
                    categoryIcons01[index].name,
                  ),
                ]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  IconButton(
                    icon: Image.asset(categoryIcons02[index].icon),
                    onPressed: () {
                      var codeName = categoryIcons02[index].name;
                      var codeValue = categoryIcons02[index].code;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PolicyListPage(
                              categoryName: codeName,
                              categoryValue: codeValue,
                            ), // 복지검색 탭
                          ));
                    },
                    iconSize: MediaQuery.of(context).size.width / 8,
                  ),
                  Text(
                    categoryIcons02[index].name,
                  ),
                ]),
                // height: 40,
                // width: size.width / 4,
                // constraints: const BoxConstraints(maxWidth: 100),
                // color: Colors.amber,
              ),
            ),
          ),
        ]);
  }
}

// 실시간 인기 글
class livePopularPost extends StatelessWidget {
  final Policy policies;
  final int ranking;
  // final Map<String, dynamic> codeData;

  const livePopularPost({
    super.key,
    required this.policies,
    required this.ranking,
    // required this.codeData
  });

  @override
  Widget build(BuildContext context) {
    final iconList = [
      Icons.looks_one,
      Icons.looks_two,
      Icons.looks_3,
      Icons.looks_4,
      Icons.looks_5,
    ];

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListTile(
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPolicyPage(policies),
                  ));
            },
            leading: Icon(
              iconList[ranking],
              //Icons.looks_one,
              color: ThemeColors.primary,
            ),
            title: Text(policies.policy_name,
                style: const TextStyle(
                  color: ThemeColors.basic,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ))));
  }
}

class _ListWithoutPopularPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        TextCustom(text: "등록된 정책이 없습니다."),
      ],
    );
  }
}

class _ShimerLoadingPopularPolicy extends StatelessWidget {
  const _ShimerLoadingPopularPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ShimmerNaru(),
        SizedBox(height: 10.0),
        ShimmerNaru(),
        SizedBox(height: 10.0),
        ShimmerNaru(),
      ],
    );
  }
}
