import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive/hive.dart';

part 'entry_model.g.dart';

@HiveType(typeId: 3)
class Entry {
  @HiveField(0)
  String id;
  @HiveField(1)
  double amount;
  @HiveField(2)
  Category category;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  String? note;

  Entry({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });
}
