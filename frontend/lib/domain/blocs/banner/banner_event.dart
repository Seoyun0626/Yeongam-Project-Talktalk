part of 'banner_bloc.dart';

@immutable
abstract class BannerEvent {}

// 이미지 선택
class OnSelectedImageEvent extends BannerEvent {
  final File imageSelected;
  OnSelectedImageEvent(this.imageSelected);
}

// 정책 검색
class OnIsSearchPolicyEvent extends BannerEvent {
  final bool isSearchPolicy;

  OnIsSearchPolicyEvent(this.isSearchPolicy);
}


// // 정책 스크랩
// class OnScrapEvent extends PolicyEvent {
//   final int scrapNumber;
//   OnScrapEvent(this.scrapNumber);
// }
