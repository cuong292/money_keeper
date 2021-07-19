import 'dart:async';

import 'package:base_flutter/base/data/api/api_service.dart';
import 'package:base_flutter/base/data/api/app_api.dart';
import 'package:base_flutter/base/data/db/app_dao.dart';
import 'package:base_flutter/base/data/storage/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_response.dart';
import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc<T extends BaseState, E extends BaseEvent>
    extends Bloc<E, T> {
  late final SharePreferenceRepository prefRepository;

  late final AppDao dbRepository;

  late final ApiService apiRepository;

  BaseBloc(BuildContext context, T initialState) : super(initialState) {
    init(context);
  }

  void init(BuildContext context) {
    this.prefRepository =
        RepositoryProvider.of<SharePreferenceRepository>(context);

    this.dbRepository = RepositoryProvider.of<AppDao>(context);

    apiRepository = AppApi.getApiService();
  }

  Future<T> onResponse<T extends BaseResponse>(
      T value, Function(T successData) onSuccess) {
    if (value.status == 1) {
      onSuccess(value.data);
      return Future.value(value);
    } else {
      return Future<T>.error(value, null);
    }
  }
// Tạm thời kệ nó đã :D
//
// Stream<T> showLoading() async* {
//   yield (state.copyWith(
//     screenStatus: ScreenStatus.LOADING,
//   ) as T);
// }
//
// Stream<T> hideLoading() async* {
//   yield (state.copyWith(
//     screenStatus: ScreenStatus.IDLE,
//   ) as T);
// }
//
// Stream<T> showError(String error) async* {
//   yield (state.copyWith(
//     screenStatus: ScreenStatus.ERROR,
//     message: error,
//   ) as T);
//   yield* hideLoading();
// }
//
// Stream<T> showNetworkError<ET extends BaseResponse>(Object? error) async* {
//   String message = S().unexpected_error;
//   if (error is ET && error.message != null) {
//     message = error.message!;
//   }
//   yield (state.copyWith(
//     screenStatus: ScreenStatus.ERROR,
//     message: message,
//   ) as T);
//
//   yield (state.copyWith(
//     screenStatus: ScreenStatus.IDLE,
//   ) as T);
// }
//
// FutureOr<TimetableResponse> handleError<ET extends BaseResponse>(
//     Object? error, StackTrace stackTrance) {
//   showNetworkError(error);
//   return Future.error(error ?? '');
// }
}
