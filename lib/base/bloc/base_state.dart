import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final ScreenStatus screenStatus;
  final String? message;
  final String screenTitle;

  BaseState({
    this.screenStatus = ScreenStatus.IDLE,
    this.message,
    this.screenTitle = '',
  });

  BaseState copyWith({ScreenStatus? screenStatus, String? message});

  @override
  // TODO: implement props
  List<Object?> get props => [
        message,
        screenStatus,
        screenTitle,
      ];
}
