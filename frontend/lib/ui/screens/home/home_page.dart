import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/blocs/auth/auth_bloc.dart';
import 'package:login/domain/blocs/user/user_bloc.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/ui/screens/user/my_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login/domain/models/response/response_banner.dart';
import 'package:login/domain/services/banner_services.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/policy/policy_search.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool loginSuccessState = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text('청소년톡 Talk',
                style: TextStyle(
                  color: ThemeColors.basic,
                  fontFamily: 'KOTRAHOPE',
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(), // MyPage
                        ));

                    // if (loginSuccessState == true) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const MyPage(),
                    //       ));
                    // } else if (loginSuccessState == false) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const LoginPage(),
                    //       ));
                    // }
                  }),
              // IconButton(
              //   icon: const Icon(Icons.search,
              //       size: 30, color: ThemeColors.basic),
              //   // onPressed: () => Navigator.push(
              //   //     context, routeSlide(page: const SearchPage())),
              //   onPressed: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const SearchPage(),
              //       )),
              // )
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
                  // buttonSection, // 카테고리 아이콘 메뉴
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                      child: Column(children: [
                        Row(children: const [
                          ImageIcon(
                            AssetImage("images/icon_check.png"),
                            color: ThemeColors.darkGreen,
                            size: 20,
                          ),
                          // Image.asset('images/icon_sparkel.png'),
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
                  CategoryButton(),
                  livePopularPost(),

                  // 로그아웃 버튼
                  BtnNaru(
                    text: '로그아웃',
                    colorText: Colors.black,
                    width: size.width,
                    onPressed: () {
                      authBloc.add(OnLogOutEvent());
                      userBloc.add(OnLogOutUser());
                      Navigator.pushAndRemoveUntil(context,
                          routeSlide(page: const HomePage()), (_) => false);
                    },
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
  BannerSlide({super.key, required this.policyBanners});

  // final BannerImage = [
  //   Image.asset('images/banner/slider_example.png', fit: BoxFit.fill),
  //   Image.asset('images/banner/mou_img.png', fit: BoxFit.fill),
  // ];
  final CarouselController _bannerController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final bannerImgName = policyBanners.banner_img;
    final bannerImgUrl = "images/banner/$bannerImgName";
    final bannerLink = policyBanners.banner_link;
    // print(bannerImgUrl);

    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(bannerLink));
      },
      child: Image.asset(bannerImgUrl, fit: BoxFit.fitWidth),
    );

    // CarouselSlider(
    //     carouselController: _bannerController,
    //     options: CarouselOptions(
    //       scrollDirection: Axis.horizontal,
    //       height: MediaQuery.of(context).size.height / 4,
    //       enlargeCenterPage: true,
    //       viewportFraction: 1.0,
    //       autoPlay: true,
    //     ),
    //     items: bannerImgAsset
    //     // bannerImgAsset.map((image) {
    //   return Builder(
    //     builder: (BuildContext context) {
    //       return SizedBox(
    //         width: MediaQuery.of(context).size.width,
    //         // margin: EdgeInsets.symmetric(horizontal: 5.0),
    //         child: ClipRRect(
    //           // borderRadius: BorderRadius.circular(10.0),
    //           child: image,
    //         ),
    //       );
    //     },
    //   );
    // }).toList(),
    // );
  }
}

// 카테고리 아이콘 버튼
class CategoryButton extends StatelessWidget {
  final List<String> pngIcons01 = [
    'images/category_icon/icon_study.png', // 학업
    'images/category_icon/icon_counseling.png', // 상담
    'images/category_icon/icon_job.png', // 취업/이직
    'images/category_icon/icon_living.png', // 생활비
  ];
  final List<String> textIcons01 = ['학업', '상담', '취업/이직', '생활비'];
  final List<String> textIcons02 = ['건강', '주거', '결혼/양육', '전체보기'];

  final List<String> pngIcons02 = [
    'images/category_icon/icon_health.png', // 건강
    'images/category_icon/icon_house.png', // 주거
    'images/category_icon/icon_baby.png', // 결혼/양육
    'images/category_icon/icon_allsee.png', // 전체보기
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
                      icon: Image.asset(pngIcons01[index]),
                      onPressed: () {},
                      iconSize: MediaQuery.of(context).size.width / 8),
                  Text(
                    textIcons01[index],
                  ),
                ]),
                // height: 40,
                // width: size.width / 4,
                // constraints: const BoxConstraints(maxWidth: 100),
                // color: Colors.amber,
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
                    icon: Image.asset(pngIcons02[index]),
                    onPressed: () {},
                    iconSize: MediaQuery.of(context).size.width / 8,
                  ),
                  Text(
                    textIcons02[index],
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
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          Row(children: const [
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
          const SizedBox(
            height: 7,
          ),
          Row(
            children: const [
              Icon(
                Icons.looks_one,
                color: ThemeColors.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text('국민취업지원제도 (취업성공패키지, 최대300만원)',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Icon(
                Icons.looks_two,
                color: ThemeColors.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text('월세자금보증(청년월세)',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Icon(
                Icons.looks_3,
                color: ThemeColors.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text('가정양육수당 지원(월~20만원)',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Icon(
                Icons.looks_4,
                color: ThemeColors.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text('생계지원비 융자',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Icon(
                Icons.looks_5,
                color: ThemeColors.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text('임신부 가사돌봄 서비스',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ]));
  }
}
