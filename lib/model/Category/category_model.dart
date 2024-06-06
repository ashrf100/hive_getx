import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int iconId; 

  Category({
    required this.id,
    required this.name,
    required this.iconId,  
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      iconId: json['iconId'],  // Add this field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconId': iconId,  // Add this field
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.iconId == iconId;  // Add this field
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ iconId.hashCode;  // Add this field
}
