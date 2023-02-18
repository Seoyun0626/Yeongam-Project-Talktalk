part of 'banner_bloc.dart';

@immutable
class BannerState {
  final List<File>? imageFileSelected;
  final bool isSearchPolicy;
  // final int scrapNumber;

  const BannerState({
    this.imageFileSelected,
    this.isSearchPolicy = false,
    // this.scrapNumber = 0,
  });

  BannerState copyWith({
    List<File>? imageSelected,
    int? scrapnumber,
    required bool isSearchPolicy,
  }) =>
      BannerState(
          imageFileSelected: imageFileSelected ?? imageFileSelected,
          isSearchPolicy: isSearchPolicy // ?? this.isSearchPolicy,
          // scrapNumber: scrapNumber // ?? this.scrapNumber,
          );
}

class LoadingPolicy extends BannerState {}
