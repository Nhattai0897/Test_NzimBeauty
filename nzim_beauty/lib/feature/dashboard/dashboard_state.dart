import '../../resource/utils/bloc_builder_status.dart';

class DashboardState {
  BlocBuilderStatusCase status;
  int indexTab;
  DashboardState({required this.status, required this.indexTab});
  DashboardState copyWith({
    BlocBuilderStatusCase? status,
    int? indexTab,
  }) {
    return DashboardState(
      status: status ?? this.status,
      indexTab: indexTab ?? this.indexTab,
    );
  }
}
