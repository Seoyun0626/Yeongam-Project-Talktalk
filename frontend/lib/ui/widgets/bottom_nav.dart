part of 'widgets.dart';

class BottomNavigation extends StatelessWidget {
  final int index;
  final bool isReel;

  const BottomNavigation({Key? key, required this.index, this.isReel = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      decoration: BoxDecoration(
          color: isReel ? Colors.black : Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: -1)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ItemButtom(
              i: 1,
              index: index,
              icon: Icons.home,
              isIcon: false,
              iconString: 'images/bottom_bar/icon_menu_home.png',
              isReel: isReel,
              iconText: '홈',
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (_) => false)),
          _ItemButtom(
              i: 2,
              index: index,
              isIcon: false,
              isReel: isReel,
              iconString: 'images/bottom_bar/icon_menu_policy.png',
              iconText: '복지검색',
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PolicyListPage(
                            categoryName: '',
                            categoryValue: '',
                          )),
                  (_) => false)),
          _ItemButtom(
              i: 3,
              index: index,
              // icon: Icons.date_range,
              isIcon: false,
              isReel: isReel,
              iconString: 'images/bottom_bar/icon_menu_keep.png',
              iconText: 'keep',
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KeepPage()),
                  )),
          _ItemButtom(
              i: 4,
              index: index,
              icon: Icons.bookmark,
              isIcon: false,
              isReel: isReel,
              iconString: 'images/bottom_bar/icon_menu_calendar.png',
              iconText: '캘린더',
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                  (_) => false)),
          _ItemButtom(
              i: 5,
              index: index,
              icon: Icons.more_horiz,
              // isIcon: false,
              isReel: isReel,
              // iconString: 'images/bottom_bar/icon_menu_more.png',
              iconText: '더보기',
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPage()),
                  (_) => false)),

          // _ItemProfile()
        ],
      ),
    );
  }
}

// class _ItemProfile extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const ProfilePage()), (_) => false),
//       child: BlocBuilder<UserBloc, UserState>(
//           builder: (_, state)
//           => state.user?.image != null
//               ? CircleAvatar(
//               radius: 15,
//               backgroundImage: NetworkImage(Environment.baseUrl+ state.user!.image )
//           )
//               : const CircleAvatar(
//               radius: 15,
//               backgroundColor: ThemeColors.primary,
//               child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//           )
//       ),
//     );
//   }
// }

class _ItemButtom extends StatelessWidget {
  final int i;
  final int index;
  final bool isIcon;
  final IconData? icon;
  final String? iconString;
  final Function() onPressed;
  final bool isReel;
  final String iconText;

  const _ItemButtom({
    Key? key,
    required this.i,
    required this.index,
    required this.onPressed,
    this.icon,
    this.iconString,
    this.isIcon = true,
    this.isReel = false,
    required this.iconText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
            //margin: const EdgeInsets.only(bottom: 10.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                (isIcon)
                    ? Icon(icon,
                        color: (i == index)
                            ? ThemeColors.darkGreen
                            : isReel
                                ? Colors.white
                                : ThemeColors.basic,
                        size: MediaQuery.of(context).size.width / 13)
                    : Image.asset(
                        iconString!,
                        height: MediaQuery.of(context).size.width / 13,
                        color: (i == index)
                            ? ThemeColors.darkGreen
                            : isReel
                                ? Colors.white
                                : ThemeColors.basic,
                      ),
                const SizedBox(
                  height: 6,
                ),
                Text(iconText),
              ],
            )));
  }
}
