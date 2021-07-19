import 'package:base_flutter/base/bloc/base_bloc.dart';
import 'package:base_flutter/base/bloc/base_event.dart';
import 'package:base_flutter/base/bloc/base_state.dart';
import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseBlocView<B extends BaseBloc<S, E>, S extends BaseState,
    E extends BaseEvent> extends StatelessWidget {
  late FToast toast;
  bool useAppBar;
  bool useSimpleAppBar;
  String screenTitle;

  bool useAppbarLeading;

  BaseBlocView({
    this.useAppBar = false,
    this.useSimpleAppBar = true,
    this.useAppbarLeading = true,
    this.screenTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (BuildContext context, state) {
        if (state.screenStatus == ScreenStatus.SUCCESS) {
          ToastUtil.showToastSuccess(toast, state.message);
        } else if (state.screenStatus == ScreenStatus.ERROR) {
          ToastUtil.showToastError(toast, state.message);
        } else if (state.screenStatus == ScreenStatus.WARNING) {
          ToastUtil.showToastWarning(toast, state.message);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ConstColor.colorPrimary,
        appBar: useAppBar ? buildAppBar(context) : null,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: getBackgroundColor(),
            child: Stack(
              children: [
                buildChild(),
                loadingIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    if (useSimpleAppBar) {
      return AppBar(
        title: Text(
          screenTitle,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: useAppbarLeading
            ? GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 20,
                  ),
                ),
              )
            : emptyView,
        brightness: Brightness.light,
      );
    } else {
      return appbarBuilder(context);
    }
  }

  // if no builder return, just show the empty app bar
  PreferredSizeWidget appbarBuilder(BuildContext? context) {
    return AppBar();
  }

  Color getBackgroundColor() {
    return ConstColor.grayF2F;
  }

  Widget loadingIndicator() {
    return BlocBuilder<B, S>(
      buildWhen: (previous, current) =>
          previous.screenStatus != current.screenStatus,
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.LOADING) {
          return CircularProgressIndicator();
        } else {
          return emptyView;
        }
      },
    );
  }

  Widget buildChild();
}
