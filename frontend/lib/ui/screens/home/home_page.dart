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
import 'package:flutter_svg/flutter_svg.dart';

final BannerImage = [
  Image.asset('images/slider_example.png', fit: BoxFit.cover),
  Image.asset('images/aco.png', fit: BoxFit.cover),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 검색창
  final TextEditingController filter = TextEditingController(); // 검색 위젯 컨트롤
  final FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태 등
  String searchText = ""; // 현재 검색어 값

  _HomePageState() {
    filter.addListener(() {
      setState(() {
        searchText = filter.text;
      });
    });
  } // filter가 변화를 검지하여 searchText의 상태를 변화시키는 코드

  Widget build(BuildContext context) {
    // 카테고리 아이콘 메뉴
    Widget buttonSection = Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Icons.school, '학업'),
            _buildButtonColumn(Icons.volunteer_activism, '상담'),
            _buildButtonColumn(Icons.work, '취업/이직'),
            _buildButtonColumn(Icons.wallet, '생활비'),
          ],
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Icons.health_and_safety, '건강'),
            _buildButtonColumn(Icons.maps_home_work, '주거'),
            _buildButtonColumn(Icons.family_restroom, '결혼/양육'),
            _buildButtonColumn(Icons.widgets, '전체보기'),
          ],
        ),
      ],
    ));
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
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            leading: InkWell(
              onTap: () =>
                  Navigator.push(context, routeSlide(page: const LoginPage())),
              child: Image.asset('images/aco.png', height: 70),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.perm_identity),
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const LoginPage())),
              )
            ],
            backgroundColor: ThemeColors.primary,
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Column(children: <Widget>[
            // 검색창
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
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
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
                    buttonSection,
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
            ),
          ]),
          bottomNavigationBar: const BottomNavigation(index: 1)),
    );
  }
}

// 카테고리 아이콘 메뉴
Column _buildButtonColumn(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: Icon(
          icon,
          size: 30,
        ),
        onPressed: () {},
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

// buttonSection
// class CategoryButton extends StatelessWidget {
//   final List<String> svgIcons01 = [
//     'images/category_icon/icon_study.svg', // 학업
//     'images/category_icon/icon_counseling.svg', // 상담
//     'images/category_icon/icon_job.svg', // 취업/이직
//     'images/category_icon/icon_living.svg', // 생활비
//   ];

//   final List<String> svgIcons02 = [
//     'images/category_icon/icon_study.svg', // 건강
//     'images/category_icon/icon_counseling.svg', // 주거
//     'images/category_icon/icon_job.svg', // 결혼/양육
//     'images/category_icon/icon_living.svg', // 전체보기
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       children: List.generate(
//         3,
//         (index) => Container(
//           margin: const EdgeInsets.only(bottom: 20.0),
//           padding: const EdgeInsets.all(10.0),
//           height: 350,
//           width: size.width,
//           // color: Colors.amber,
//           child: SvgPicture.asset(svgIcons01[index], height: 15),
//         ),
//       ),
//     );
//   }
// }
