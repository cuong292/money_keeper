import 'package:base_flutter/data/bill.dart';
import 'package:base_flutter/data/bill_by_month.dart';
import 'package:base_flutter/data/user.dart';
import 'package:floor/floor.dart';

@dao
abstract class AppDao {
  @insert
  Future<void> insertBill(Bill bill);

  @Query('SELECT * FROM Bill')
  Future<List<Bill>> getAllBills();

  @Query('SELECT * FROM Bill WHERE monthId = :id')
  Future<List<Bill>> getBillsByMonth(int id);

  @insert
  Future<void> insertBillOfMonth(BillByMonth bill);

  @Query('SELECT * FROM BillByMonth WHERE userId = :userId')
  Future<List<BillByMonth>> getBillOfMonth(int userId);

  @Query('SELECT * FROM BillByMonth WHERE month = :month AND userId = :userId')
  Future<BillByMonth?> getBillByMonth(int month, int userId);

  @Update()
  Future<void> updateBillOfMonth(BillByMonth bom);

  @Query('SELECT * FROM User')
  Future<List<User>> getUsers();

  @insert
  Future<void> saveUser(User user);
}
