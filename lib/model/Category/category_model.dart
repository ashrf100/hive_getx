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
}
