import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nzim_beauty/model/banner_response_model.dart';
import '../../model/course_response_model.dart';
import '../../model/technicians_response_model.dart';
import '../../resource/utils/bloc_builder_status.dart'; 
import '../../resource/core/urls.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  late BuildContext mainContext;

  final List<Tab> tabs = [
    const Tab(
        child: Text('Liệu trình',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ))),
    const Tab(
        child: Text('Dịch vụ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ))),
  ];

  final List<TechniciansModel> techniciansLst = [
    TechniciansModel(id: 01, name: "X.Mai", url: CoreUrls.urlImg1),
    TechniciansModel(id: 02, name: "T.Hoa", url: CoreUrls.urlImg2),
    TechniciansModel(id: 03, name: "K.Thuy", url: CoreUrls.urlImg3),
    TechniciansModel(id: 04, name: "T.Hoang", url: CoreUrls.urlImg4),
    TechniciansModel(id: 05, name: "K.Tu", url: CoreUrls.urlImg1),
    TechniciansModel(id: 06, name: "T.Dao", url: CoreUrls.urlImg2)
  ];
  final List<CourseModel> coursesLst = [
    CourseModel(
        id: 01, title: "Gói thải độc Detox 75’", url: CoreUrls.urlImg1),
    CourseModel(
        id: 02, title: "Phi kim tế bào gốc (3 bước)", url: CoreUrls.urlImg2),
    CourseModel(id: 03, title: "Điện di vitamin C", url: CoreUrls.urlImg3),
    CourseModel(id: 05, title: "Aqua Peeling", url: CoreUrls.urlImg4)
  ];

  HomeBloc()
      : super(HomeState(status: BlocBuilderStatusCase.initial, bannerLst: []));
  void initContext(BuildContext context) {
    mainContext = context;
    getBannerData();
  }

  Future<void> getBannerData() async {
    emit(state.copyWith(status: BlocBuilderStatusCase.loading));
    var dataBanner = await fakeCallGetBannerAPI();
    if (dataBanner != null) {
      emit(state.copyWith(
          bannerLst: dataBanner, status: BlocBuilderStatusCase.success));
    } else {
      emit(state.copyWith(
          bannerLst: null, status: BlocBuilderStatusCase.failure));
    }
  }

  Future<List<BannerModel>?> fakeCallGetBannerAPI() async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      BannerModel(
          id: 01,
          title: "Tạm biệt khuyết điểm, trả lại bờ môi hồng",
          url: CoreUrls.urlImg3),
      BannerModel(
          id: 02,
          title: "Tạm biệt khuyết điểm, trả lại bờ môi hồng 2",
          url: CoreUrls.urlImg3),
      BannerModel(
          id: 03,
          title: "Tạm biệt khuyết điểm, trả lại bờ môi hồng 3",
          url: CoreUrls.urlImg3),
      BannerModel(
          id: 04,
          title: "Tạm biệt khuyết điểm, trả lại bờ môi hồng 4",
          url: CoreUrls.urlImg3),
      BannerModel(
          id: 05,
          title: "Tạm biệt khuyết điểm, trả lại bờ môi hồng 5",
          url: CoreUrls.urlImg3)
    ];
  }
}
