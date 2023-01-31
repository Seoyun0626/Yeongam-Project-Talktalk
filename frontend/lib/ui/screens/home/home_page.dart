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
  Image.asset('images/banner/slider_example.png', fit: BoxFit.fill),
  // Image.asset('images/banner/aco.png', fit: BoxFit.cover),
  Image.asset('images/banner/mou_img.png', fit: BoxFit.fill),
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
      debugShowCheckedModeBanner: false,
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
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
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
                              Text('기관별 정책을 확인하세요!',
                                  style: TextStyle(
                                    color: ThemeColors.basic,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ])
                          ])),

                      SizedBox(
                        width: 5,
                      ),
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

// 카테고리 아이콘 버튼
class CategoryButton extends StatelessWidget {
  final List<String> pngIcons01 = [
    'images/main_icon/icon_main_1.png', // 영암군
    'images/main_icon/icon_main_2.png', // 청소년수련관
    'images/main_icon/icon_main_3.png', // 방과후아카데미
  ];
  final List<String> textIcons01 = ['영암군', '청소년수련관', '방과후아카데미'];
  final List<String> textIcons02 = [
    '청소년상담\n복지센터',
    '학교밖청소년\n지원센터',
    '삼호읍청소년\n문화의집'
  ];

  final List<String> pngIcons02 = [
    'images/main_icon/icon_main_4.png', // 청소년상담복지센터
    'images/main_icon/icon_main_5.png', // 학교밖청소년지원센터
    'images/main_icon/icon_main_6.png', // 삼호읍청소년문화의집
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
              3,
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
                    style: TextStyle(fontWeight: FontWeight.w500),
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
              3,
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
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
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
