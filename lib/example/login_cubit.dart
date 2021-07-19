import 'package:base_flutter/base/bloc/base_cubit.dart';
import 'package:base_flutter/example/login_state.dart';
import 'package:flutter/material.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(BuildContext context, LoginState initialState)
      : super(context, initialState);
}
