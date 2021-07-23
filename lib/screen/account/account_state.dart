import 'package:base_flutter/base/bloc/base_state.dart';
import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:base_flutter/data/user.dart';

class AccountState extends BaseState {
  List<User>? users;

  @override
  AccountState copyWith({
    ScreenStatus? screenStatus,
    String? message,
    List<User>? users,
  }) {
    return AccountState(
      screenStatus: screenStatus ?? this.screenStatus,
      message: message ?? this.message,
      users: users ?? this.users,
    );
  }

  AccountState({
    ScreenStatus screenStatus = ScreenStatus.IDLE,
    String? message,
    this.users,
  }) : super(
          screenStatus: screenStatus,
          message: message,
          screenTitle: 'Tài khoản',
        );

  @override
  // TODO: implement props
  List<Object?> get props => super.props
    ..addAll([
      users,
    ]);
}
