import 'package:base_flutter/base/bloc/base_state.dart';
import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:base_flutter/data/bill_by_month.dart';
import 'package:base_flutter/data/user.dart';

class HomeState extends BaseState {
  List<BillByMonth>? items;
  User user;

  HomeState(
    this.user, {
    ScreenStatus screenStatus = ScreenStatus.IDLE,
    String? message,
    this.items,
  }) : super(
          screenStatus: screenStatus,
          message: message,
          screenTitle: 'Home',
        );

  @override
  HomeState copyWith({
    ScreenStatus? screenStatus,
    String? message,
    List<BillByMonth>? items,
  }) {
    return HomeState(
      this.user,
      message: message ?? this.message,
      screenStatus: screenStatus ?? this.screenStatus,
      items: items ?? this.items,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => super.props
    ..addAll([
      items,
      user,
    ]);
}
