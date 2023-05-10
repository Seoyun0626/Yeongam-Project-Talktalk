import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login/data/env/env.dart';
import 'package:login/domain/blocs/auth/auth_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/ui/screens/policy/policy_detail_page.dart';
import 'package:login/ui/screens/policy/policy_list_page.dart';
import 'package:login/ui/screens/user/myTalkTalk_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login/domain/models/response/response_banner.dart';
import 'package:login/domain/services/banner_services.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

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
          backgroundColor: ThemeColors.third,
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text('청소년 톡talk',
                style: TextStyle(
                  color: ThemeColors.primary,
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
                    color: ThemeColors.primary,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const LoginPage(),
                    //     ));

                    if (authBloc.state is LogOut) {
                      // 로그인 상태가 아닐 경우 LoginPage로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    } else {
                      // 로그인 상태일 경우 MyPage로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyPage()),
                      );
                    }
                  }),
            ],
            backgroundColor: Colors.white, //ThemeColors.primary,
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  // const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  // const EdgeInsets.all(15),
                  const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 배너 슬라이드
                  FutureBuilder<List<Banners>>(
                    future: bannerService.getBannerData(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          children: const [ShimmerNaru(), ShimmerNaru()],
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
                    height: 15,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(15),
                      // margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                      child: Column(children: [
                        Row(children: const [
                          Icon(
                            Icons.category,
                            color: ThemeColors.primary,
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
                          TextCustom(
                            text: '카테고리별 정책을 확인하세요!',
                            color: Colors.black, //ThemeColors.basic,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ]),
                        const SizedBox(
                          width: 5,
                        ),
                        // 카테고리 아이콘
                        CategoryButton(),
                      ])),
                  const SizedBox(
                    height: 15,
                  ),

                  // 실시간 인기글
                  Container(
                    // height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    // margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PolicyListPage(
                                codeName: '',
                                codeDetail: '',
                              ), // 복지검색 탭
                            )),
                        child: Column(children: [
                          Row(children: const [
                            Icon(
                              Icons.auto_awesome,
                              color: ThemeColors.primary,
                            ),
                            // Image.asset('images/icon_sparkel.png'),
                            SizedBox(
                              width: 5,
                            ),
                            TextCustom(
                              text: '지금 인기있는 정책은?',
                              color: Colors.black, //ThemeColors.basic,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ]),
                          const SizedBox(
                            height: 15,
                          ),
                          // 실시간 인기글
                          FutureBuilder<List<Policy>>(
                              future: policyService.getAllPolicy(),
                              builder: ((_, snapshot) {
                                if (snapshot.data != null &&
                                    snapshot.data!.isEmpty) {
                                  return _ListWithoutPopularPolicy();
                                }
                                if (!snapshot.hasData) {
                                  return _ListWithoutPopularPolicy(); //const _ShimerLoadingPopularPolicy();
                                } else {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length > 5
                                          ? 5
                                          : snapshot.data!.length,
                                      itemBuilder: (_, i) => livePopularPolicy(
                                          // codeData: codeData,
                                          ranking: i,
                                          policies: snapshot.data![i]));
                                }
                              })),
                        ])),
                  ),

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
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            bannerImgUrl,
            fit: BoxFit.cover,
          )),
    );
  }
}

class HomeCategory {
  final String name;
  final String code;
  final String codeName;
  final String icon;
  HomeCategory(
      {required this.name,
      required this.code,
      required this.codeName,
      required this.icon});
}

// 카테고리 아이콘 버튼
class CategoryButton extends StatelessWidget {
  static String codeName = 'policy_field_code';

  final List<HomeCategory> categoryIcons01 = [
    HomeCategory(
        name: '학업',
        code: '00',
        codeName: codeName,
        icon: 'images/category_icon/icon_study.svg'),
    HomeCategory(
        name: '상담',
        code: '01',
        codeName: codeName,
        icon: 'images/category_icon/icon_counseling.svg'),
    HomeCategory(
        name: '취업/이직',
        code: '02',
        codeName: codeName,
        icon: 'images/category_icon/icon_health.svg'),
    HomeCategory(
        name: '생활비',
        code: '03',
        codeName: codeName,
        icon: 'images/category_icon/icon_money.svg'),
  ];

  final List<HomeCategory> categoryIcons02 = [
    HomeCategory(
        name: '건강',
        code: '04',
        codeName: codeName,
        icon: 'images/category_icon/icon_teenagers.svg'),
    HomeCategory(
        name: '주거',
        code: '05',
        codeName: codeName,
        icon: 'images/category_icon/icon_schoolOut.svg'),
    HomeCategory(
        name: '결혼/양육',
        code: '06',
        codeName: codeName,
        icon: 'images/category_icon/icon_caring.svg'),
    HomeCategory(
        name: '전체보기',
        code: '',
        codeName: codeName,
        icon: 'images/category_icon/icon_total.svg'),
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
                      icon: SvgPicture.asset(
                          categoryIcons01[index].icon), //pngIcons01[index]
                      onPressed: () {
                        var codeName = categoryIcons01[index].codeName;
                        var codeValue = categoryIcons01[index].code;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PolicyListPage(
                                codeName: codeName,
                                codeDetail: codeValue,
                              ), // 복지검색 탭
                            ));
                      },
                      iconSize: 35), //MediaQuery.of(context).size.width / 8),
                  TextCustom(
                    text: categoryIcons01[index].name,
                    fontSize: 15,
                    color: ThemeColors.basic,
                    // fontWeight: FontWeight.w600,
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
                    icon: SvgPicture.asset(categoryIcons02[index].icon),
                    onPressed: () {
                      var codeName = categoryIcons02[index].codeName;
                      var codeValue = categoryIcons02[index].code;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PolicyListPage(
                              codeName: codeName,
                              codeDetail: codeValue,
                            ), // 복지검색 탭
                          ));
                    },
                    iconSize: 35, //MediaQuery.of(context).size.width / 8,
                  ),
                  TextCustom(
                    text: categoryIcons02[index].name,
                    fontSize: 15,
                    color: ThemeColors.basic,
                    // fontWeight: FontWeight.w600,
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
class livePopularPolicy extends StatelessWidget {
  final Policy policies;
  final int ranking;
  // final Map<String, dynamic> codeData;

  const livePopularPolicy({
    super.key,
    required this.policies,
    required this.ranking,
    // required this.codeData
  });

  @override
  Widget build(BuildContext context) {
    final iconList = [
      Icons.looks_one_outlined,
      Icons.looks_two_outlined,
      Icons.looks_3_outlined,
      Icons.looks_4_outlined,
      Icons.looks_5_outlined,
    ];

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
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
            title: TextCustom(
              text: policies.policy_name,
              color: ThemeColors.basic,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )));
  }
}

class _ListWithoutPopularPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/aco4.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextCustom(text: '등록된 정책이 없어요', fontSize: 20),
            ],
          ),
        ));
  }
}

class _ShimerLoadingPopularPolicy extends StatelessWidget {
  const _ShimerLoadingPopularPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ShimmerNaru(),
        SizedBox(height: 5.0),
        ShimmerNaru(),
        SizedBox(height: 5.0),
        ShimmerNaru(),
      ],
    );
  }
}
