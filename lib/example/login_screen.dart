import 'package:base_flutter/base/screen/base_cubit_view_state.dart';
import 'package:base_flutter/example/login_cubit.dart';
import 'package:base_flutter/example/login_state.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState
    extends BaseCubitViewState<LoginScreen, LoginCubit, LoginState> {
  @override
  Widget buildChild() {
    return GestureDetector(
      onHorizontalDragDown: (details) {
        print(details);
      },
      onHorizontalDragStart: (details) {
        print(details);
      },
    );
  }

  LoginScreenState()
      : super(
          useAppBar: true,
          useSimpleAppBar: true,
          useAppbarLeading: false,
          screenTitle: 'Login',
        );
}
