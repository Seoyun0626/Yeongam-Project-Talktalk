part of 'policy_bloc.dart';

@immutable
class PolicyState {
  final List<File>? imageFileSelected;
  final bool isSearchPolicy;
  // final int scrapNumber;

  const PolicyState({
    this.imageFileSelected,
    this.isSearchPolicy = false,
    // this.scrapNumber = 0,
  });

  PolicyState copyWith({
    List<File>? imageSelected,
    int? scrapnumber,
    required bool isSearchPolicy,
  }) =>
      PolicyState(
          imageFileSelected: imageFileSelected ?? imageFileSelected,
          isSearchPolicy: isSearchPolicy // ?? this.isSearchPolicy,
          // scrapNumber: scrapNumber // ?? this.scrapNumber,
          );
}

class LoadingPolicy extends PolicyState {}
