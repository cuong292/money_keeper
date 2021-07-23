import 'package:base_flutter/base/bloc/base_cubit.dart';
import 'package:base_flutter/base/bloc/screen_status.dart';
import 'package:base_flutter/data/bill.dart';
import 'package:base_flutter/data/bill_by_month.dart';
import 'package:base_flutter/utils/date_time_util.dart';
import 'package:flutter/material.dart';

import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(BuildContext context, HomeState initialState)
      : super(context, initialState) {
    getBills();
  }

  Future<void> getBills() async {
    showLoading();
    DateTime currentDate = DateTime.now();
    List<BillByMonth> billByMonth = await dbRepository.getBillOfMonth(
      state.user.id ?? 0,
    );
    int currentMonth = DateTimeUtils.monthByDate(
      currentDate.millisecondsSinceEpoch,
    );
    if (!billByMonth.contains(
      BillByMonth(
        month: currentMonth,
      ),
    )) {
      int year = currentDate.year;
      int month = currentDate.month;
      if (month == 1) {
        month = 12;
        year -= 1;
      } else {
        month -= 1;
      }
      int previousMonth = DateTimeUtils.monthByDate(
          DateTime(year, month).millisecondsSinceEpoch);
      BillByMonth? bbm = await dbRepository.getBillByMonth(
        previousMonth,
        state.user.id ?? 0,
      );
      BillByMonth thisMonth = BillByMonth(
        month: currentMonth,
        surplus: bbm == null ? 0 : bbm.surplus,
        items: [],
      );
      thisMonth.userId = state.user.id;
      print('${state.user.id} day la id');
      await dbRepository.insertBillOfMonth(thisMonth);
      billByMonth = await dbRepository.getBillOfMonth(state.user.id!);
    }

    for (int i = 0; i < billByMonth.length; i++) {
      List<Bill> bills = await dbRepository.getBillsByMonth(
        billByMonth[i].id ?? 0,
      );
      bills.sort((a, b) => b.date!.compareTo(a.date!));
      billByMonth[i].items = bills;
    }
    billByMonth.sort((a, b) => b.month!.compareTo(a.month!));
    emit(
      state.copyWith(
        items: billByMonth,
      ),
    );
    hideLoading();
  }

  Future<bool> addBill(String reason, String money, int checked) async {
    int moneyValue = int.parse(money.replaceAll('.', ''));
    switch (checked) {
      case 1:
        moneyValue *= 1000;
        break;
      case 2:
        moneyValue *= 100000;
        break;
      case 3:
        moneyValue *= 1000000;
        break;
    }
    int currentMonth =
        DateTimeUtils.monthByDate(DateTime.now().millisecondsSinceEpoch);

    BillByMonth? billOfMonth = await dbRepository.getBillByMonth(
      currentMonth,
      state.user.id ?? 0,
    );

    Bill bill = Bill(
      name: reason,
      money: moneyValue,
      date: DateTime.now().millisecondsSinceEpoch,
      monthId: billOfMonth!.id,
    );

    billOfMonth.surplus += moneyValue;
    if (moneyValue < 0) {
      billOfMonth.paid += (moneyValue).abs();
    }
    await dbRepository.updateBillOfMonth(billOfMonth);
    await dbRepository.insertBill(bill);
    List<BillByMonth> bbm = []..addAll(state.items!);
    bbm[0].items!.insert(0, bill);
    bbm[0].surplus += moneyValue;
    if (moneyValue < 0) {
      bbm[0].paid += (moneyValue).abs();
    }
    state.items = [];
    emit(
      state.copyWith(
        items: bbm,
        screenStatus: ScreenStatus.SUCCESS,
        message: 'Lưu thành công',
      ),
    );
    hideLoading();
    return true;
  }
}
