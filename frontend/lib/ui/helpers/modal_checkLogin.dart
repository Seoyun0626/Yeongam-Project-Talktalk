import 'package:flutter/material.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import 'animation_route.dart';

class modalCheckLogin {
  void showBottomDialog(
    BuildContext context,
  ) {
    Future.delayed(Duration.zero, () {
      showGeneralDialog(
        barrierLabel: "showGeneralDialog",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.7),
        transitionDuration: const Duration(milliseconds: 400),
        context: context,
        pageBuilder: (context, _, __) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: _buildDialogContent(context),
          );
        },
        transitionBuilder: (_, animation1, __, child) {
          return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(animation1),
              child: child);
        },
      );
    });
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: double.maxFinite,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Material(
        color: Colors.white,
        child: Column(
          children: [
            _buildCancelIcon(context),
            const SizedBox(height: 10),
            _buildContinueText(),
            const SizedBox(height: 5),
            _buildExtraText(),
            const SizedBox(height: 16),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelIcon(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      height: 25,
      child: IconButton(
        icon: const Icon(Icons.close),
        iconSize: 20,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildContinueText() {
    return const TextCustom(
      text: '로그인하고 \n나에게 필요한 정책을 관리해보세요',
      textAlign: TextAlign.center,
      maxLines: 2,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
  }

  Widget _buildExtraText() {
    return const TextCustom(
      text: '다양한 이벤트도 참여할 수 있어요!',
      fontSize: 12,
      color: ThemeColors.basic,
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 20,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: ThemeColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: RawMaterialButton(
        onPressed: () {
          // Navigator.of(context, rootNavigator: true).pop();
          Navigator.push(context, routeSlide(page: const LoginPage()));
        },
        child: const Center(
            child: TextCustom(
          text: '로그인하러가기',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        )),
      ),
    );
  }
}
