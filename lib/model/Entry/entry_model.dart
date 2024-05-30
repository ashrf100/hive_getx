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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category.toJson(), // Convert Category to JSON
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      amount: json['amount'],
      category: Category.fromJson(json['category']), // Convert JSON to Category
      date: DateTime.parse(json['date']),
      note: json['note'],
    );
  }
}
