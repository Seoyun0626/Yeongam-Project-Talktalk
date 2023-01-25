part of 'policy_bloc.dart';

@immutable
class PolicyState {
  final List<File>? imageFileSelected;
  // final int scrapNumber;

  const PolicyState({
    this.imageFileSelected,
    // this.scrapNumber = 0,
  });

  PolicyState copyWith({
    List<File>? imageSelected,
    int? scrapnumber,
  }) =>
      PolicyState(
        imageFileSelected: imageFileSelected ?? imageFileSelected,
        // scrapNumber: scrapNumber // ?? this.scrapNumber,
      );
}

class LoadingPolicy extends PolicyState {}
