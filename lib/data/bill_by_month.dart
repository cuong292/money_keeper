import 'package:base_flutter/data/bill.dart';
import 'package:base_flutter/data/user.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'BillByMonth',
)
class BillByMonth extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  int? month;
  int surplus;
  int paid;
  int? userId;
  @ignore
  List<Bill>? items;

  BillByMonth({
    this.items,
    this.id,
    this.surplus = 0,
    this.paid = 0,
    this.month,
    this.userId,
  });

  List<Bill> get data => items ?? [];

  @override
  // TODO: implement props
  List<Object?> get props => [month];
}
