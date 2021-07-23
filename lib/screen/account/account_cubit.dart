import 'dart:convert';

import 'package:base_flutter/base/bloc/base_cubit.dart';
import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:base_flutter/data/bill_by_month.dart';
import 'package:base_flutter/data/user.dart';
import 'package:base_flutter/screen/account/account_state.dart';
import 'package:base_flutter/utils/date_time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountCubit extends BaseCubit<AccountState> {
  AccountCubit(BuildContext context, AccountState initialState)
      : super(context, initialState) {
    getUser();
  }

  getUser() async {
    List<User> users = await dbRepository.getUsers();
    int month =
        DateTimeUtils.monthByDate(DateTime.now().millisecondsSinceEpoch);
    for (int i = 0; i < users.length; i++) {
      BillByMonth? bbm =
          await dbRepository.getBillByMonth(month, users[i].id ?? 0);
      if (bbm != null) {
        users[i].paid = bbm.paid;
        users[i].surplus = bbm.surplus;
      }
    }
    emit(
      state.copyWith(
        users: users,
      ),
    );
  }

  Future<void> createAccount(
      BuildContext context, String name, String image) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    print('id cua user : ${id}');
    User user = User(
      id: id,
      userName: name,
      imageUrl: image,
    );
    await dbRepository.saveUser(user);
    var newList = await dbRepository.getUsers();
    emit(
      state.copyWith(
        users: newList,
        message: "Tạo thành công",
        screenStatus: ScreenStatus.SUCCESS,
      ),
    );
    hideLoading();
    Navigator.of(context).pop();
  }
}
