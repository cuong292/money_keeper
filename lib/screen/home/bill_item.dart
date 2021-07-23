import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/data/bill_by_month.dart';
import 'package:base_flutter/screen/home/home_state.dart';
import 'package:base_flutter/utils/date_time_util.dart';
import 'package:base_flutter/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'home_cubit.dart';

class BillItem extends StatelessWidget {
  BillByMonth billByMonth;

  BillItem(this.billByMonth);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => ExpansionTile(
        initiallyExpanded: DateTimeUtils.isThisMonth(billByMonth.month),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateTimeUtils.dateFormatMMM.format(
                DateTime.fromMillisecondsSinceEpoch(
                  billByMonth.month!,
                ),
              ),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Tiêu : ${NumberFormat("#,###").format(billByMonth.paid)}đ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ConstColor.redFF5),
                  ),
                  height5view,
                  Text(
                    'Còn lại : ${NumberFormat("#,###").format(billByMonth.surplus)}đ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: billByMonth.surplus < 0
                          ? ConstColor.redFF5
                          : ConstColor.colorPrimary,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        children: billByMonth.data
            .map(
              (e) => WidgetUtils.borderContainer(
                backgroundColor: ConstColor.grayF2F,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateTimeUtils.dateFormatddMMyyyy2.format(
                        DateTime.fromMillisecondsSinceEpoch(e.date ?? 0),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    width5view,
                    Expanded(
                      child: Text(
                        e.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    width5view,
                    Text(
                      '${NumberFormat("#,###").format(e.money)}đ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: e.money! < 0
                            ? ConstColor.redFF5
                            : ConstColor.colorPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
