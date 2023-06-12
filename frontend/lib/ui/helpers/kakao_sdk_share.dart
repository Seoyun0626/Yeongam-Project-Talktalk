// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoShareService {
  // 정책 공유 템플릿
  FeedTemplate getSharePolicyTemplate(
      String policyName, String policyImgLink, String link) {
    print(policyImgLink);
    print(link);
    Content content = Content(
        title: policyName,
        imageUrl: Uri.parse(policyImgLink),
        link: Link(webUrl: Uri.parse(link)));
    FeedTemplate template = FeedTemplate(content: content, buttons: [
      Button(title: "자세히 보기", link: Link(webUrl: Uri.parse(link)))
    ]);

    return template;
  }

  // Future<String> buildDynamicLink(String policyId) async {
  //   String url = "https://teentalktalk.page.link"; //firebase

  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //       uriPrefix: url,
  //       // 딥링크 사용을 위한 특정 정책 id 구성
  //       link: Uri.parse('$url/$policyId'),
  //       //안드로이드 packageName
  //       androidParameters:
  //           const AndroidParameters(packageName: "com.example.teentalktalk"));

  //   final dynamicLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //   return dynamicLink.shortUrl.toString();
  // }

  Future<void> kakaoSharePolicy(
      String policyName, String policyImgLink, String link) async {
    // 카카오톡 실행 가능 여부 확인
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      var template = getSharePolicyTemplate(policyName, policyImgLink, link);
      try {
        Uri uri = await ShareClient.instance.shareDefault(template: template);
        await ShareClient.instance.launchKakaoTalk(uri);
        // Uri shareUrl =
        //     await WebSharerClient.instance.makeDefaultUrl(template: template);
        // await launchBrowserTab(shareUrl, popupOpen: true);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {} catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }
  }

  // Future<void> kakaoSharePolicy(String policyName, String policyLink) async {
  //   // 사용자 정의 템플릿 ID
  //   int templateId = 94734;
  //   // 카카오톡 실행 가능 여부 확인
  //   bool isKakaoTalkSharingAvailable =
  //       await ShareClient.instance.isKakaoTalkSharingAvailable();

  //   if (isKakaoTalkSharingAvailable) {
  //     try {
  //       Uri uri =
  //           await ShareClient.instance.shareCustom(templateId: templateId);
  //       await ShareClient.instance.launchKakaoTalk(uri);
  //       print('카카오톡 공유 완료');
  //     } catch (error) {
  //       print('카카오톡 공유 실패 $error');
  //     }
  //   } else {
  //     try {
  //       Uri shareUrl = await WebSharerClient.instance.makeCustomUrl(
  //           templateId: templateId, templateArgs: {'key1': 'value1'});
  //       await launchBrowserTab(shareUrl, popupOpen: true);
  //     } catch (error) {
  //       print('카카오톡 공유 실패 $error');
  //     }
  //   }
  // }
}

final KakaoShareServices = KakaoShareService();
