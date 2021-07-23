import 'package:base_flutter/base/screen/base_cubit_appbar.dart';
import 'package:base_flutter/base/screen/base_cubit_view.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/screen/home/create_bill_widget.dart';
import 'package:base_flutter/screen/home/home_cubit.dart';
import 'package:base_flutter/screen/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bill_item.dart';

class HomeScreen extends BaseCubitView<HomeCubit, HomeState> {
  static const SCREEN_NAME = "/home_screen";

  @override
  // TODO: implement useAppBar
  bool get useAppBar => true;

  @override
  // TODO: implement useSimpleAppBar
  bool get useSimpleAppBar => false;

  @override
  Color getBackgroundColor() {
    // TODO: implement getBackgroundColor
    return Colors.white;
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext parentContext) {
    return PreferredSize(
      child: BaseCubitAppBar<HomeCubit, HomeState>(
        showRightAction: true,
        rightIconRsc: Icons.add,
        onRightClick: () {
          showModalBottomSheet<void>(
            context: parentContext,
            builder: (context) => BlocProvider<HomeCubit>.value(
              value: BlocProvider.of<HomeCubit>(parentContext),
              child: CreateBillWidget(),
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
          );
        },
      ),
      preferredSize: Size.fromHeight(56),
    );
  }

  @override
  Widget buildChild() {
    return Positioned.fill(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => state.items == null
            ? emptyView
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return BillItem(state.items![index]);
                  },
                  itemCount: state.items!.length,
                ),
              ),
      ),
    );
  }
}
