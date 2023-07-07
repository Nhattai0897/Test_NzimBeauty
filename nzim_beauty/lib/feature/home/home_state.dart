import '../../model/banner_response_model.dart';
import '../../resource/utils/bloc_builder_status.dart';

class HomeState {
  BlocBuilderStatusCase status;
  List<BannerModel> bannerLst;

  HomeState({required this.status, required this.bannerLst});

  HomeState copyWith(
      {BlocBuilderStatusCase? status, List<BannerModel>? bannerLst}) {
    return HomeState(
        status: status ?? this.status, bannerLst: bannerLst ?? this.bannerLst);
  }
}
