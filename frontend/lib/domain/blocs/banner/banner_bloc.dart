import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:login/domain/services/policy_services.dart';
part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  List<File> listImages = [];

  BannerBloc() : super(const BannerState()) {
    on<OnSelectedImageEvent>(_onSelectedImage);
    on<OnIsSearchPolicyEvent>(_isSearchPolicy);
    // on<OnScrapEvent>(_onScrapEvent);
  }

  Future<void> _onSelectedImage(
      OnSelectedImageEvent event, Emitter<BannerState> emit) async {
    listImages.add(event.imageSelected);
    emit(state.copyWith(imageSelected: listImages, isSearchPolicy: false));
  }

  Future<void> _isSearchPolicy(
      OnIsSearchPolicyEvent event, Emitter<BannerState> emit) async {
    emit(state.copyWith(isSearchPolicy: event.isSearchPolicy));
  }
}
