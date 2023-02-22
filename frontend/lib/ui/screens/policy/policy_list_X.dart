// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:filter_list/filter_list.dart';
// import 'package:http/http.dart';
// import 'package:login/domain/models/response/response_policy.dart';
// import 'package:login/domain/services/code_service.dart';
// import 'package:login/domain/services/policy_services.dart';
// import 'package:login/ui/helpers/helpers.dart';
// import 'package:login/ui/screens/policy/policy_detail.dart';
// import 'package:login/ui/screens/policy/search_filter.dart';
// import 'package:login/ui/themes/theme_colors.dart';
// import 'package:login/ui/widgets/widgets.dart';
// import 'package:login/domain/blocs/policy/policy_bloc.dart';

// class PolicyListPage extends StatefulWidget {
//   const PolicyListPage({Key? key, required this.categoryValue})
//       : super(key: key);
//   final String categoryValue;

//   @override
//   State<PolicyListPage> createState() => _PolicyListPageState();
// }

// class _PolicyListPageState extends State<PolicyListPage> {
//   @override
//   Widget build(BuildContext context) {
//     final String catagoryCode = widget.categoryValue;
//     // print('home_page - categoryCode : ' + catagoryCode);

//     return BlocListener<PolicyBloc, PolicyState>(
//         listener: (context, state) {
//           if (state is LoadingPolicy) {
//             modalLoadingShort(context);
//           }
//         },
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: Scaffold(
//               appBar: AppBar(
//                 backgroundColor: ThemeColors.primary,
//                 toolbarHeight: 10,
//                 elevation: 0,
//               ),
//               body: SafeArea(
//                 child: Column(
//                   children: <Widget>[
//                     const SearchBar(),
//                     Container(
//                       color: Colors.white,
//                       height: 43,
//                       padding: const EdgeInsets.all(13),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: const [
//                             TextCustom(
//                               text: "검색결과",
//                               color: ThemeColors.basic,
//                               fontSize: 15.0,
//                             ),
//                             Icon(
//                               Icons.arrow_drop_down_circle_outlined,
//                               color: ThemeColors.basic,
//                             ),
//                           ]),
//                     ),
//                     Expanded(
//                       child: ListView(
//                         physics: const BouncingScrollPhysics(),
//                         children: [
//                           FutureBuilder<List<Policy>>(
//                               future: policyService.getAllPolicy(),
//                               builder: (_, snapshot) {
//                                 if (snapshot.data != null &&
//                                     snapshot.data!.isEmpty) {
//                                   return _ListWithoutPolicy();
//                                 }

//                                 return BlocBuilder<PolicyBloc, PolicyState>(
//                                     // buildWhen: (previous, current) =>
//                                     //     previous != current,
//                                     builder: (context, state) => !state
//                                             .isSearchPolicy
//                                         ? FutureBuilder<List<Policy>>(
//                                             future: policyService
//                                                 .getAllPolicyForSearch(),
//                                             builder: (_, snapshot) {
//                                               if (snapshot.data != null &&
//                                                   snapshot.data!.isEmpty) {
//                                                 return _ListWithoutPolicySearch();
//                                               }

//                                               return !snapshot.hasData
//                                                   ? const _ShimerLoading()
//                                                   : _ListPolicySearch(
//                                                       policies: snapshot.data!);
//                                             },
//                                           )
//                                         : streamSearchPolicy());

//                                 // 정책 리스트
//                                 // return !snapshot.hasData
//                                 //     ? const _ShimerLoading()
//                                 //     : ListView.builder(
//                                 //         physics:
//                                 //             const NeverScrollableScrollPhysics(),
//                                 //         shrinkWrap: true,
//                                 //         itemCount: snapshot.data!.length,
//                                 //         itemBuilder: (_, i) => ListViewPolicy(
//                                 //               policies: snapshot.data![i],
//                                 //               // searhConditions: catagoryCode,
//                                 //             ));
//                               })
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: const BottomNavigation(index: 2)),
//         ));
//   }

//   Widget streamSearchPolicy() {
//     return StreamBuilder<List<Policy>>(
//       stream: policyService.searchProducts,
//       builder: (context, snapshot) {
//         if (snapshot.data == null) {
//           return Container();
//         }

//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.data!.isEmpty) {
//           return ListTile(
//             title: const Text(
//               '검색 결과 없음',
//               // '${_searchController.text}에 대한 검색 결과 없음',
//               style: TextStyle(color: ThemeColors.basic),
//             ),
//           );
//         }

//         return _ListPolicySearch(policies: snapshot.data!);
//       },
//     );
//   }
// }

// class _ListPolicySearch extends StatelessWidget {
//   final List<Policy> policies;
//   const _ListPolicySearch({Key? key, required this.policies}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: policies.length,
//         itemBuilder: (context, i) {
//           final String imgName = policies[i].img;

//           final String imgUrl = "images/policy/$imgName";
//           // "app/src/public/upload/policy/$imgName";

//           final String startDateYear =
//               policies[i].application_start_date.substring(0, 4);
//           final String endDateYear =
//               policies[i].application_end_date.substring(0, 4);
//           final String startDateMonth =
//               policies[i].application_start_date.substring(5, 7);
//           final String endDateMonth =
//               policies[i].application_end_date.substring(5, 7);
//           final String startDateDay =
//               policies[i].application_start_date.substring(8, 10);
//           final String endDateDay =
//               policies[i].application_end_date.substring(8, 10);
//           final String startDate =
//               '$startDateYear.$startDateMonth.$startDateDay';
//           final String endDate = '$endDateYear.$endDateMonth.$endDateDay';

//           return Padding(
//               padding: const EdgeInsets.fromLTRB(3, 3, 3, 0), // 카드 바깥쪽
//               child: Card(
//                 child: Padding(
//                     padding: const EdgeInsets.all(7), // 카드 안쪽
//                     child: InkWell(
//                         splashColor: ThemeColors.primary.withAlpha(30),
//                         onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     DetailPolicyPage(policies[i]),
//                               ),
//                             ),
//                         child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.all(0),
//                                 child: SizedBox(
//                                   // 이미지
//                                   width: 80.0,
//                                   height: 80.0,
//                                   child: Image(
//                                     image: AssetImage(imgUrl),
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                   child: Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           10, 0, 10, 0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Text(
//                                             policies[i].policy_institution_code,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 color: ThemeColors.basic),
//                                           ), // 주최측
//                                           const SizedBox(
//                                             height: 3,
//                                           ),
//                                           Text(
//                                             policies[i].policy_name,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold),
//                                           ), // 정책 제목
//                                           Container(
//                                             margin:
//                                                 const EdgeInsets.only(top: 5),
//                                             padding: const EdgeInsets.all(3),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color: ThemeColors.secondary,
//                                             ),
//                                             child: Text(
//                                               '$startDate ~ $endDate',
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: const TextStyle(
//                                                   fontSize: 10.0,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ), // 모집 기간
//                                           const SizedBox(
//                                             height: 3,
//                                           ),
//                                           Text(
//                                             policies[i].policy_field_code,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 color: ThemeColors.basic),
//                                           ), // 카테고리
//                                         ],
//                                       ))),
//                               SizedBox(
//                                 // decoration: BoxDecoration(color: Colors.grey[350]),
//                                 width: 80.0,
//                                 height: 80.0,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.bookmark_border,
//                                         size: 30,
//                                         color: ThemeColors.basic,
//                                       ),
//                                       onPressed: () {},
//                                     ),
//                                     const Text('0',
//                                         style: TextStyle(
//                                             color: ThemeColors.basic,
//                                             fontSize: 10))
//                                   ],
//                                 ),
//                               ),
//                             ]))),
//               ));
//         });
//   }
// }

// // 검색창
// class SearchBar extends StatefulWidget {
//   const SearchBar({Key? key}) : super(key: key);

//   @override
//   State<SearchBar> createState() => _SearchBar();
// }

// class _SearchBar extends State<SearchBar> {
//   late TextEditingController _searchController;
//   late FocusNode myFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//     myFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     _searchController.clear();
//     _searchController.dispose();
//     myFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final String inputText = widget.inputText;
//     final size = MediaQuery.of(context).size;
//     final policyBloc = BlocProvider.of<PolicyBloc>(context);

//     return Container(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
//         color: ThemeColors.primary,
//         child: Container(
//           padding: const EdgeInsets.only(right: 5.0),
//           height: 45,
//           width: size.width,
//           decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(10.0)),
//           child: BlocBuilder<PolicyBloc, PolicyState>(
//             builder: (context, state) => TextField(
//               textInputAction: TextInputAction.go,
//               onSubmitted: (value) {
//                 setState(() {});
//               },
//               focusNode: myFocusNode,
//               autofocus: false,
//               controller: _searchController,
//               onChanged: (value) {
//                 // print(value);
//                 if (value.isNotEmpty) {
//                   policyBloc.add(OnIsSearchPolicyEvent(true));
//                   policyService.searchPolicy(value);
//                 } else {
//                   policyBloc.add(OnIsSearchPolicyEvent(false));
//                 }
//               },
//               cursorColor: ThemeColors.darkGreen,
//               decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: '복지 검색',
//                   // hintStyle: GoogleFonts.roboto(fontSize: 17),
//                   prefixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.tune,
//                       size: 20,
//                       color: ThemeColors.darkGreen,
//                     ),
//                     onPressed: () {
//                       // searchFilterDialog();
//                       Navigator.push(
//                         context,
//                         routeSlide(
//                           page: PolicySearchFilterPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   suffixIcon: myFocusNode.hasFocus
//                       ? IconButton(
//                           icon: const Icon(
//                             Icons.cancel,
//                             size: 20,
//                             color: ThemeColors.darkGreen,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _searchController.clear();
//                               // _searchText = "";
//                               policyBloc.add(OnIsSearchPolicyEvent(false));
//                               myFocusNode.unfocus();
//                             });
//                           },
//                         )
//                       : IconButton(
//                           icon: const Icon(
//                             Icons.search_rounded,
//                             color: ThemeColors.darkGreen,
//                           ),
//                           onPressed: () {},
//                           // onPressed: () => Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) =>
//                           //         const PolicyListPage(),
//                           //   ),
//                           // ),
//                         )),
//             ),
//           ),
//         ));
//   }
// }

// // 정책 리스트
// class ListViewPolicy extends StatefulWidget {
//   final Policy policies;
//   const ListViewPolicy({Key? key, required this.policies}) : super(key: key);

//   @override
//   State<ListViewPolicy> createState() => _ListViewPolicyState();
// }

// class _ListViewPolicyState extends State<ListViewPolicy> {
//   // final String policy_institution_code = 'policy_institution_code';
//   // // final String policy_target_code = 'policy_target_code';
//   // // final String policy_field_code = 'policy_field_code';
//   // // final String policy_character_code = 'policy_character_code';
//   // late String institution = '';
//   // // late String target = '';
//   // // late String field = '';
//   // // late String character = '';

//   // getInstitutionCodeData(String code) async {
//   //   var data = await codeService.getCodeData(policy_institution_code, code);
//   //   // print(data);
//   //   return data;
//   // }

//   // // getTargetCodeData() async {
//   // //   var data = await codeService.getCodeData(policy_target_code);
//   // //   // print(data);
//   // //   return data;
//   // // }

//   // // getFieldCodeData(String code) async {
//   // //   var data = await codeService.getCodeData(policy_field_code, code);
//   // //   // print(data);
//   // //   return data;
//   // // }

//   // // getCharacterCodeData() async {
//   // //   var data = await codeService.getCodeData(policy_character_code);
//   // //   // print(data);
//   // //   return data;
//   // // }

//   // @override
//   // void initState() {
//   //   var institutionCode = getInstitutionCodeData('00').then((value) {
//   //     setState(() {
//   //       institution = value;
//   //     });
//   //   });
//   //   // getTargetCodeData().then((value) {
//   //   //   setState(() {
//   //   //     target = value;
//   //   //   });
//   //   // });
//   //   // getFieldCodeData('00').then((value) {
//   //   //   setState(() {
//   //   //     field = value;
//   //   //   });
//   //   // });
//   //   // getCharacterCodeData().then((value) {
//   //   //   setState(() {
//   //   //     character = value;
//   //   //   });
//   //   // });

//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final Policy policies = widget.policies;
//     // final size = MediaQuery.of(context).size;
//     // final policyBloc = BlocProvider.of<PolicyBloc>(context);
//     final String imgName = policies.img;
//     final String imgUrl =
//         "images/policy/$imgName"; //"app/src/public/upload/policy/$imgName";

//     // 모집 기간
//     final String startDateYear =
//         policies.application_start_date.substring(0, 4);
//     final String endDateYear = policies.application_end_date.substring(0, 4);
//     final String startDateMonth =
//         policies.application_start_date.substring(5, 7);
//     final String endDateMonth = policies.application_end_date.substring(5, 7);
//     final String startDateDay =
//         policies.application_start_date.substring(8, 10);
//     final String endDateDay = policies.application_end_date.substring(8, 10);
//     final String startDate = '$startDateYear.$startDateMonth.$startDateDay';
//     final String endDate = '$endDateYear.$endDateMonth.$endDateDay';

//     final String institutionCode = policies.policy_institution_code; // 기관 코드
//     final String targetCode = policies.policy_target_code; // 적용 대상 코드
//     final String fieldCode = policies.policy_field_code; // 분야 코드
//     final String characterCode = policies.policy_character_code;

//     return Padding(
//         padding: const EdgeInsets.fromLTRB(3, 3, 3, 0), // 카드 바깥쪽
//         child: Card(
//           child: Padding(
//               padding: const EdgeInsets.all(7), // 카드 안쪽
//               child: InkWell(
//                   splashColor: ThemeColors.primary.withAlpha(30),
//                   onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailPolicyPage(policies),
//                         ),
//                       ),
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(0),
//                           child: SizedBox(
//                             // 이미지
//                             width: 80.0,
//                             height: 80.0,
//                             child: Image(
//                               image: AssetImage(imgUrl),
//                               fit: BoxFit.fitWidth,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                             child: Padding(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       // test,
//                                       // institution,
//                                       policies.policy_institution_code,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                           fontSize: 12.0,
//                                           color: ThemeColors.basic),
//                                     ), // 주최측
//                                     const SizedBox(
//                                       height: 3,
//                                     ),
//                                     Text(
//                                       policies.policy_name,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ), // 정책 제목
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 5),
//                                       padding: const EdgeInsets.all(3),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: ThemeColors.secondary,
//                                       ),
//                                       child: Text(
//                                         '$startDate ~ $endDate',
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             fontSize: 10.0,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ), // 모집 기간
//                                     const SizedBox(
//                                       height: 3,
//                                     ),

//                                     Text(
//                                       // field,
//                                       policies.policy_field_code,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                       ),
//                                     ), // 카테고리
//                                   ],
//                                 ))),
//                         SizedBox(
//                           // decoration: BoxDecoration(color: Colors.grey[350]),
//                           width: 80.0,
//                           height: 80.0,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // 스크랩
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.bookmark_border,
//                                   size: 30,
//                                   color: ThemeColors.basic,
//                                 ),
//                                 onPressed: () {},
//                               ),
//                               Text(policies.scrap.toString(),
//                                   style: const TextStyle(
//                                       color: ThemeColors.basic, fontSize: 10))
//                             ],
//                           ),
//                         ),
//                       ]))),
//         ));
//   }
// }

// class _ListWithoutPolicy extends StatelessWidget {
//   // final List<String> svgPosts = [
//   //   'assets/svg/without-posts-home.svg',
//   //   'assets/svg/without-posts-home.svg',
//   //   'assets/svg/mobile-new-posts.svg',
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         TextCustom(text: "등록된 정책이 없습니다."),
//       ],
//       // children: List.generate(3, (index) => Container(
//       //     margin: const EdgeInsets.only(bottom: 20.0),
//       //     padding: const EdgeInsets.all(10.0),
//       //     height: 350,
//       //     width: size.width,
//       //     // color: Colors.amber,
//       //     child: SvgPicture.asset(svgPosts[index], height: 15),
//       //   ),
//       // ),
//     );
//   }
// }

// class _ListWithoutPolicySearch extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         TextCustom(text: "등록된 정책이 없습니다."),
//       ],
//     );
//   }
// }

// class _ShimerLoading extends StatelessWidget {
//   const _ShimerLoading({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const [
//         ShimmerNaru(),
//         SizedBox(height: 10.0),
//         ShimmerNaru(),
//         SizedBox(height: 10.0),
//         ShimmerNaru(),
//       ],
//     );
//   }
// }
