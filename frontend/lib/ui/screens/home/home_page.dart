import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/user/my_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

final BannerImage = [
  Image.asset('images/slider_example.png', fit: BoxFit.fill),
  Image.asset('images/aco.png', fit: BoxFit.cover),
  Image.asset('images/mou_img.png', fit: BoxFit.fill),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final CarouselController _controller = CarouselController(); // 배너 슬라이드

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text('청소년톡talk',
                style: TextStyle(
                  color: ThemeColors.basic,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            leading: InkWell(
              onTap: () =>
                  Navigator.push(context, routeSlide(page: const LoginPage())),
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
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    )),
                // onPressed: () => Navigator.push(
                //   context, routeSlide(page: const LoginPage())),

                // }
              )
            ],
            backgroundColor: ThemeColors.primary,
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Column(children: <Widget>[
            const SearchBar(),
            Expanded(
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 배너 슬라이드
                      CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          height: MediaQuery.of(context).size.height / 4,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          autoPlay: true,
                        ),
                        items: BannerImage.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(10.0),
                                  child: image,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // buttonSection, // 카테고리 아이콘 메뉴
                      CategoryButton(),
                      livePopularPost(),
                      // const TextCustom(
                      //     text: 'MainPage',
                      //     letterSpacing: 1.5,
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 28,
                      //     color: Color.fromARGB(255, 93, 73, 98)),
                      // const SizedBox(height: 30.0),

                      // 로그아웃 버튼
                      // BtnNaru(
                      //   text: '로그아웃',
                      //   colorText: Colors.black,
                      //   width: size.width,
                      //   onPressed: () {
                      //     authBloc.add(OnLogOutEvent());
                      //     userBloc.add(OnLogOutUser());
                      //     Navigator.pushAndRemoveUntil(context,
                      //         routeSlide(page: const HomePage()), (_) => false);
                      //   },
                      // ),
                      // const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ]),
            )
          ]),
          bottomNavigationBar: const BottomNavigation(index: 1)),
    );
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
    final size = MediaQuery.of(context).size;
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
                    iconSize: 50,
                  ),
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
                    iconSize: 50,
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
            Text('실시간 인기 글',
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
          Row(
            children: const [
              Icon(
                Icons.looks_6,
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
                Icons.looks_6,
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
                Icons.looks_6,
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
          )
        ]));
  }
}
