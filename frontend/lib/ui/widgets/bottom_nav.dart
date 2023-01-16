part of 'widgets.dart';

class BottomNavigation extends StatelessWidget {
  final int index;
  final bool isReel;

  const BottomNavigation({Key? key, required this.index, this.isReel = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: isReel ? Colors.black : Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 9, spreadRadius: -4)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ItemButtom(
            i: 1,
            index: index,
            icon: Icons.home,
            isIcon: false,
            iconString: 'images/bottom_bar/icon_menu_home.png',
            isReel: isReel,
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: const HomePage()), (_) => false),
          ),
          _ItemButtom(
            i: 2,
            index: index,
            isIcon: false,
            isReel: isReel,
            iconString: 'images/bottom_bar/icon_menu_policy.png',
            onPressed: () => Navigator.pushAndRemoveUntil(context,
                routeSlide(page: const SearchPolicyPage()), (_) => false),
          ),
          _ItemButtom(
            i: 3,
            index: index,
            // icon: Icons.date_range,
            isIcon: false,
            isReel: isReel,
            iconString: 'images/bottom_bar/icon_menu_keep.png',
            onPressed: () =>
                Navigator.push(context, routeSlide(page: const HomePage())),
          ),
          _ItemButtom(
            i: 4,
            index: index,
            icon: Icons.bookmark,
            isIcon: false,
            isReel: isReel,
            iconString: 'images/bottom_bar/icon_menu_calendar.png',
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: const HomePage()), (_) => false),
          ),
          _ItemButtom(
            i: 4,
            index: index,
            // icon: Icons.more_horiz,
            isIcon: false,
            isReel: isReel,
            iconString: 'images/bottom_bar/icon_menu_more.png',
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: const HomePage()), (_) => false),
          ),
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

  const _ItemButtom({
    Key? key,
    required this.i,
    required this.index,
    required this.onPressed,
    this.icon,
    this.iconString,
    this.isIcon = true,
    this.isReel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        child: (isIcon)
            ? Icon(icon,
                color: (i == index)
                    ? ThemeColors.primary
                    : isReel
                        ? Colors.white
                        : const Color.fromRGBO(77, 77, 77, 1),
                size: 28)
            : Image.asset(iconString!,
                height: 25,
                color: (i == index)
                    ? ThemeColors.primary
                    : isReel
                        ? Colors.white
                        : const Color.fromRGBO(77, 77, 77, 1)),
      ),
    );
  }
}
