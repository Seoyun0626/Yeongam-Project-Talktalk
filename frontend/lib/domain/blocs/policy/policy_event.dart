part of 'policy_bloc.dart';

@immutable
abstract class PolicyEvent {}

// 이미지 선택
class OnSelectedImageEvent extends PolicyEvent {
  final File imageSelected;
  OnSelectedImageEvent(this.imageSelected);
}

// 정책 검색
class OnIsSearchPolicyEvent extends PolicyEvent {
  final bool isSearchPolicy;

  OnIsSearchPolicyEvent(this.isSearchPolicy);
}


// // 정책 스크랩
// class OnScrapEvent extends PolicyEvent {
//   final int scrapNumber;
//   OnScrapEvent(this.scrapNumber);
// }
