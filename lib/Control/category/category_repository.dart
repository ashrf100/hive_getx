import 'package:hive_test/core/data_source/data_source_repository.dart';
import 'package:hive_test/model/Category/category_model.dart';

abstract class CategoryRepository {
  Future<void> addCategory(Category category);
  Future<Category?> getCategory(String id);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<List<Category>> getAllCategories();
}

class HiveCategoryRepository implements CategoryRepository {
  final HiveRepository<Category> hiveRepository;

  HiveCategoryRepository(this.hiveRepository);

  @override
  Future<void> addCategory(Category category) async {
    await hiveRepository.create(category, category.id);
  }

  @override
  Future<Category?> getCategory(String id) async {
    return await hiveRepository.read(id);
  }

  @override
  Future<void> updateCategory(Category category) async {
    await hiveRepository.update(category.id, category);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await hiveRepository.delete(id);
  }

  @override
  Future<List<Category>> getAllCategories() async {
    return await hiveRepository.getAll();
  }
}
