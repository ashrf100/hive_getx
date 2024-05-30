import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      // Parse other properties as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
