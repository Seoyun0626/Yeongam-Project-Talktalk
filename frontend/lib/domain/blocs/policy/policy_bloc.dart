import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:login/domain/services/policy_services.dart';
part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  // List<File> listImages = [];

  PolicyBloc() : super(const PolicyState()) {
    // on<OnSelectedImageEvent>(_onSelectedImage);
    on<OnIsSearchPolicyEvent>(_isSearchPolicy);
    // on<OnIsSearchPolicyEvent>(_isSelectPolicy);
    // on<OnScrapEvent>(_onScrapEvent);
  }

  // Future<void> _onSelectedImage(
  //     OnSelectedImageEvent event, Emitter<PolicyState> emit) async {
  //   listImages.add(event.imageSelected);
  //   emit(state.copyWith(imageSelected: listImages, isSearchPolicy: false));
  // }

  Future<void> _isSearchPolicy(
      OnIsSearchPolicyEvent event, Emitter<PolicyState> emit) async {
    emit(state.copyWith(isSearchPolicy: event.isSearchPolicy));
  }

  // Future<void> _isSelectPolicy(
  //     OnIsSelectPolicyEvent event, Emitter<PolicyState> emit) async {
  //   emit(state.copyWith(
  //       isSearchPolicy: false, isSelectPolicy: event.isSelectPolicy));
  // }
}
