// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:login/domain/models/response/response_terms.dart';
import 'package:login/domain/services/auth_services.dart';
import 'package:login/domain/services/dataif_services.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/register/user_type.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import 'package:login/ui/helpers/animation_route.dart';

class termsDetailPage extends StatefulWidget {
  final int termsCode;
  const termsDetailPage({Key? key, required this.termsCode}) : super(key: key);

  @override
  State<termsDetailPage> createState() => _termsDetailPageState();
}

class _termsDetailPageState extends State<termsDetailPage> {
  late Future<ResponseTerms> _termsDataFuture;

  @override
  void initState() {
    super.initState();
    _termsDataFuture = dataIfServices.getTermsData();
  }

  @override
  Widget build(BuildContext context) {
    final int termsCode = widget.termsCode;
    // print(termsCode);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<ResponseTerms>(
        future: _termsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String content = '';
            if (termsCode == 0) {
              content = snapshot.data!.termsData.first.terms;
            } else if (termsCode == 1) {
              content = snapshot.data!.termsData.first.privacy;
            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextCustom(
                        text: '서비스 이용약관',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      TextCustom(
                        text: content,
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
