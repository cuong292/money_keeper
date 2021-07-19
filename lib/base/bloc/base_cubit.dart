import 'dart:async';

import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:base_flutter/base/data/api/api_service.dart';
import 'package:base_flutter/base/data/api/app_api.dart';
import 'package:base_flutter/base/data/db/app_dao.dart';
import 'package:base_flutter/base/data/storage/sp_utils.dart';
import 'package:base_flutter/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_response.dart';
import 'base_state.dart';

class BaseCubit<T extends BaseState> extends Cubit<T> {
  late final SharePreferenceRepository prefRepository;

  late final AppDao dbRepository;

  late final ApiService coreApiRepository;

  ApiService get apiRepository => AppApi.getApiService();

  BaseCubit(BuildContext context, T initialState) : super(initialState) {
    init(context);
  }

  void init(BuildContext context) {
    this.prefRepository =
        RepositoryProvider.of<SharePreferenceRepository>(context);

    this.dbRepository = RepositoryProvider.of<AppDao>(context);
  }

  Future<T> onResponse<T extends BaseResponse>(
      T value, Function(dynamic successData) onSuccess) {
    if (value.status == 1 && value.data != null) {
      onSuccess(value.data);
      hideLoading();
      return Future.value(value);
    } else {
      return Future<T>.error(value, null);
    }
  }

  void showLoading() {
    emit(state.copyWith(
      screenStatus: ScreenStatus.LOADING,
    ) as T);
  }

  void hideLoading() {
    emit(state.copyWith(
      screenStatus: ScreenStatus.IDLE,
    ) as T);
  }

  void showError(String error) {
    emit(state.copyWith(
      screenStatus: ScreenStatus.ERROR,
      message: error,
    ) as T);
    hideLoading();
  }

  void showNetworkError<ET extends BaseResponse>(Object? error) {
    String message = S().unexpected_error;
    if (error is ET && error.message != null && error.message!.isNotEmpty) {
      message = error.message!;
    }
    emit(state.copyWith(
      screenStatus: ScreenStatus.ERROR,
      message: message,
    ) as T);
    hideLoading();
  }

  FutureOr<ET> handleError<ET extends BaseResponse>(
      Object? error, StackTrace stackTrace) {
    showNetworkError(error);
    return Future.error(error ?? '');
  }
}
