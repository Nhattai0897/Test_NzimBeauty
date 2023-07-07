import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_bloc.dart';
import 'dashboard_state.dart';

class DashboardMain extends StatelessWidget {
  const DashboardMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DashBoardTabbedBloc>(
          create: (context) => DashBoardTabbedBloc()),
    ], child: const DashboardHome());
  }
}

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome>
    with SingleTickerProviderStateMixin {
  final _selectedItemColor = const Color.fromRGBO(252, 164, 175, 1);
  final _unselectedBgColor = Colors.grey[100];
  int _selectedIndex = 0;
  late DashBoardTabbedBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DashBoardTabbedBloc>(context);
    bloc.initContext(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => bloc.initDataUI());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardTabbedBloc, DashboardState>(
        builder: (context, state) {
      _selectedIndex = state.indexTab;
      return Scaffold(
          backgroundColor: const Color.fromRGBO(255, 247, 248, 1),
          bottomNavigationBar: buildNavigateBottomTabbar(),
          body: SafeArea(
              top: true,
              child: IndexedStack(
                  index: _selectedIndex, children: bloc.contentBodyList)));
    });
  }

  Widget buildNavigateBottomTabbar() {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BottomNavigationBar(
            backgroundColor: _unselectedBgColor,
            elevation: 0,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: _buildIcon(
                      "assets/icon/ic_feed_active.png", 'Trang chủ', 0),
                  label: 'Trang chủ'),
              BottomNavigationBarItem(
                  icon: _buildIcon(
                      "assets/icon/ic_health_normal.png", 'Dịch vụ', 1),
                  label: 'Dịch vụ'),
              BottomNavigationBarItem(
                  icon: _buildIcon(
                      "assets/icon/ic_record_normal.png", 'Lịch hẹn', 2),
                  label: 'Lịch hẹn'),
              BottomNavigationBarItem(
                  icon: _buildIcon(
                      "assets/icon/ic_account_normal.png", 'Cá nhân', 3),
                  label: 'Cá nhân'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: _selectedItemColor,
            unselectedItemColor: Colors.white,
          ),
        ));
  }

  Widget _buildIcon(String asset, String text, int index) => SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: Colors.white,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(asset,
                    color: _getItemColor(index), width: index == 3 ? 20 : 23),
                const SizedBox(height: 5),
                Text(text,
                    style: TextStyle(
                        fontSize: 10.5,
                        color: _getTextColor(index),
                        fontWeight: FontWeight.w700)),
              ],
            ),
            onTap: () => bloc.pushIndexData(index),
          ),
        ),
      );

  Color _getItemColor(int index) => _selectedIndex == index
      ? index == 0
          ? _selectedItemColor
          : const Color.fromARGB(255, 250, 72, 60)
      : const Color.fromRGBO(253, 190, 198, 0.6);

  Color _getTextColor(int index) => _selectedIndex == index
      ? Colors.black
      : const Color.fromRGBO(179, 179, 179, 1);
}
