import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/register/info_first.dart';
import 'package:login/ui/screens/register/info_parents.dart';
import 'package:login/ui/screens/register/user_type.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import 'package:login/ui/helpers/animation_route.dart';

// kth 수정 : 밑에 수정 전 코드 주석처리 해놓음
class termsAgreePage extends StatefulWidget {
  const termsAgreePage({Key? key}) : super(key: key);

  @override
  State<termsAgreePage> createState() => _termsAgreePageState();
}

class _termsAgreePageState extends State<termsAgreePage> {
  final allChecked = CheckBoxModal(
    title: '약관 전체 동의',
  );
  final checkboxList = [
    CheckBoxModal(title: '이용약관 동의 (필수)'),
    CheckBoxModal(title: '개인정보침해방침 동의 (필수)'),
    CheckBoxModal(title: '마케팅 정보 수신 동의'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: const Text("약관 동의"),
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                // const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
                const EdgeInsets.all(40),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextCustom(
                  text: '약관동의',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                ListTile(
                  onTap: () => onAllClicked(allChecked),
                  leading: Checkbox(
                    value: allChecked.value,
                    onChanged: (value) => onAllClicked(allChecked),
                  ),
                  title: Text(allChecked.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const Divider(),
                ...checkboxList
                    .map((item) => ListTile(
                          onTap: () => onItemClicked(item),
                          leading: Checkbox(
                            value: item.value,
                            onChanged: (value) => onItemClicked(item),
                          ),
                          title: Text(item.title,
                              style: const TextStyle(fontSize: 18)),
                        ))
                    .toList(),
                const SizedBox(
                  height: 20,
                ),
                BtnNaru(
                  text: '완료',
                  width: 350,
                  height: 40,
                  fontSize: 18,
                  colorText: Colors.black,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const userTypePage(),
                      )),
                ),
              ],
            )),
          ),
        ],
      ),
    ));
  }

  onAllClicked(CheckBoxModal checkBoxItem) {
    final newValue = !checkBoxItem.value;
    setState(() {
      checkBoxItem.value = newValue;
      checkboxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModal checkBoxItem) {
    final newValue = !checkBoxItem.value;
    setState(() {
      checkBoxItem.value = newValue;

      if (!newValue) {
        // This is List checkbox not checked full all => So not need checked
        allChecked.value = false;
      } else {
        // This is List checkbox checked full => So need checked allChecked
        final allListChecked = checkboxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }
}

class CheckBoxModal {
  String title;
  bool value;

  CheckBoxModal({required this.title, this.value = false});
}












// class termsAgreePage extends StatefulWidget {
//   //const termsAgreePage({Key? key}) : super(key: key);
//   final Todo todo;
//   // 생성자는 Todo를 인자로 받습니다.
//   const termsAgreePage({Key? key, required this.todo}) : super(key: key);

//   @override
//   State<termsAgreePage> createState() => _termsAgreePageState();
// }

// class _termsAgreePageState extends State<termsAgreePage> {
//   var _allChecked = false;
//   var _isChecked1 = false;
//   var _isChecked2 = false;
//   var _isChecked3 = false;
//   void _doSomething() {}

//   @override
//   Widget build(BuildContext context) {
//     print(widget.todo.title);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         // title: const Text("약관 동의"),
//         elevation: 0,
//         leading: IconButton(
//           icon:
//               const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const TextCustom(
//                   text: '약관동의',
//                   letterSpacing: 2.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w900,
//                   fontSize: 30,
//                 ),
//                 const SizedBox(
//                   height: 50.0,
//                 ),
//                 Row(
//                   children: [
//                     Material(
//                       child: Checkbox(
//                         activeColor: ThemeColors.primary,
//                         value: _allChecked,
//                         onChanged: (value) {
//                           setState(() {
//                             _allChecked = value ?? false;
//                           });
//                         },
//                       ),
//                     ),
//                     const TextCustom(
//                       text: '약관 전체동의',
//                       letterSpacing: 2.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                       overflow: TextOverflow.ellipsis,
//                     )
//                   ],
//                 ),
//                 Container(
//                   height: 1.0,
//                   width: 500.0,
//                   color: Colors.black,
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Row(
//                   children: [
//                     Material(
//                       child: Checkbox(
//                         activeColor: ThemeColors.primary,
//                         value: _isChecked1,
//                         onChanged: (value) {
//                           setState(() {
//                             _isChecked1 = value ?? false;
//                           });
//                         },
//                       ),
//                     ),
//                     const TextCustom(
//                       text: '(필수) ',
//                       letterSpacing: 2.0,
//                       color: Colors.red,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const TextCustom(
//                       text: '이용약관 동의',
//                       letterSpacing: 2.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                       overflow: TextOverflow.ellipsis,
//                     )
//                   ],
//                 ),
//                 //const SizedBox(height: 5.0),
//                 Row(
//                   children: [
//                     Material(
//                       child: Checkbox(
//                         activeColor: ThemeColors.primary,
//                         value: _isChecked2,
//                         onChanged: (value) {
//                           setState(() {
//                             _isChecked2 = value ?? false;
//                           });
//                         },
//                       ),
//                     ),
//                     const TextCustom(
//                       text: '(필수) ',
//                       letterSpacing: 2.0,
//                       color: Colors.red,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const TextCustom(
//                       text: '개인정보침해방침 동의',
//                       letterSpacing: 2.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                       overflow: TextOverflow.ellipsis,
//                     )
//                   ],
//                 ),
//                 Row(children: [
//                   Material(
//                     child: Checkbox(
//                       activeColor: ThemeColors.primary,
//                       value: _isChecked3,
//                       onChanged: (value) {
//                         setState(() {
//                           _isChecked3 = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   const TextCustom(
//                     text: '마케팅정보수신 동의',
//                     letterSpacing: 2.0,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ]),
//                 const SizedBox(
//                   height: 30.0,
//                 ),
//                 BtnNaru(
//                   text: '완료',
//                   width: 350,
//                   height: 40,
//                   fontSize: 18,
//                   colorText: Colors.black,
//                   onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RegisterPage2(),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
