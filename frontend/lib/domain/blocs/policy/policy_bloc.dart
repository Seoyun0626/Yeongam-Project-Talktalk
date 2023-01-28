import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:login/domain/services/policy_services.dart';
part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  List<File> listImages = [];

  PolicyBloc() : super(const PolicyState()) {
    on<OnSelectedImageEvent>(_onSelectedImage);
    // on<OnScrapEvent>(_onScrapEvent);
  }
  Future<void> _onSelectedImage(
      OnSelectedImageEvent event, Emitter<PolicyState> emit) async {
    listImages.add(event.imageSelected);
    emit(state.copyWith(imageSelected: listImages));
  }
}
