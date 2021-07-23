import 'package:base_flutter/data/bill_by_month.dart';
import 'package:floor/floor.dart';

// bill type = 1 -> thu, bill type = 2 -> chi
@Entity(
  tableName: 'Bill',
)
class Bill {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? name;
  int? date;
  int? money;
  int? monthId;

  Bill({
    this.id,
    this.name,
    this.date,
    this.money,
    this.monthId,
  });
}
