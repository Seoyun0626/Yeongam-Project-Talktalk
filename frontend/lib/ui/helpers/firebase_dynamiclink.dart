import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> buildDynamicLink(String policyId) async {
  String url =
      "https://teentalktalk.page.link"; // Firebase Dynamic Links 도메인 주소

  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: url,
    link: Uri.parse('$url/policy/$policyId'), // 정책 ID를 링크에 추가
    androidParameters: const AndroidParameters(
      packageName: "com.example.teentalktalk", // 안드로이드 앱 패키지 이름
    ),
    // iosParameters: IosParameters(
    //   bundleId: "com.example.teentalktalk", // iOS 앱의 번들 ID
    // ),
  );

  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  // print(dynamicLink);
  final Uri shortUrl = dynamicLink.shortUrl;
  // print(shortUrl.toString());
  return shortUrl.toString();
}
