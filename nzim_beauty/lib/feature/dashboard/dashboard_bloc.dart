import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../resource/utils/bloc_builder_status.dart';
import '../home/home_screen.dart';
import 'dashboard_state.dart';

class DashBoardTabbedBloc extends Cubit<DashboardState> {
  List<double> listPosition = [];
  List<Widget> contentBodyList = <Widget>[
    const HomeMain(),
    Container(color: const Color.fromRGBO(255, 247, 248, 1)),
    Container(color: const Color.fromRGBO(255, 247, 248, 1)),
    Container(color: const Color.fromRGBO(255, 247, 248, 1))
  ];
  late BuildContext mainContext;
  late double screenWidth, screenHeight;

  DashBoardTabbedBloc()
      : super(
            DashboardState(status: BlocBuilderStatusCase.initial, indexTab: 0));

  void initDataUI() {
    screenHeight = MediaQuery.of(mainContext).size.height;
    screenWidth = MediaQuery.of(mainContext).size.width;
    genListPosition(screenWidth, contentBodyList.length);
  }

  void initContext(BuildContext context) => mainContext = context;

  void pushIndexData(int index) => emit(state.copyWith(indexTab: index));

  void genListPosition(double screenWidth, int countList) => listPosition =
      List<double>.generate(countList, (i) => i == 0 ? 0 : screenWidth * i);
}
