import 'package:base_flutter/base/screen/base_cubit_appbar.dart';
import 'package:base_flutter/base/screen/base_cubit_view.dart';
import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/screen/account/account_cubit.dart';
import 'package:base_flutter/screen/account/account_state.dart';
import 'package:base_flutter/screen/home/home_screen.dart';
import 'package:base_flutter/utils/image_widget_util.dart';
import 'package:base_flutter/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'create_account_widget.dart';

class AccountScreen extends BaseCubitView<AccountCubit, AccountState> {
  @override
  // TODO: implement useAppBar
  bool get useAppBar => true;

  @override
  // TODO: implement useSimpleAppBar
  bool get useSimpleAppBar => false;

  @override
  PreferredSizeWidget appbarBuilder(BuildContext buildContext) {
    // TODO: implement appbarBuilder
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: BaseCubitAppBar<AccountCubit, AccountState>(
        showLeftAction: false,
        showRightAction: true,
        rightIconRsc: Icons.add,
        onRightClick: () {
          showModalBottomSheet(
              context: buildContext,
              builder: (context) => BlocProvider<AccountCubit>.value(
                    value: BlocProvider.of<AccountCubit>(buildContext),
                    child: CreateAccountWidget(),
                  ),
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ));
        },
      ),
    );
  }

  @override
  // TODO: implement screenTitle
  String get screenTitle => 'Tài khoản';

  @override
  Widget buildChild() {
    return Positioned.fill(
      child: BlocBuilder<AccountCubit, AccountState>(
        buildWhen: (previous, current) => previous.users != current.users,
        builder: (context, state) => Column(
          children: [
            if (state.users != null)
              ...state.users!.map(
                (e) => GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                      HomeScreen.SCREEN_NAME,
                      arguments: e,
                    );
                    context.read<AccountCubit>().getUser();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: WidgetUtils.borderContainer(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    backgroundColor: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ImageWidgetUtil.userAvatar(
                          e.imageUrl ?? '',
                          56,
                          e.userName,
                          '',
                        ),
                        width8view,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.userName ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            height5view,
                            RichText(
                              text: TextSpan(
                                text: 'Đã tiêu trong tháng : ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${NumberFormat("#,###").format(e.paid ?? 0)}đ',
                                    style: TextStyle(
                                      color: ConstColor.redFF5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            height5view,
                            RichText(
                              text: TextSpan(
                                text: 'Số dư : ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${NumberFormat("#,###").format(e.surplus ?? 0)}đ',
                                    style: TextStyle(
                                      color: ConstColor.colorPrimary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}
