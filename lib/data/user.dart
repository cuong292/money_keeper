import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? userName;
  String? imageUrl;

  @ignore
  int? paid;

  @ignore
  int? surplus;

  User({
    this.id,
    this.userName,
    this.imageUrl,
    this.surplus,
    this.paid,
  });
}
