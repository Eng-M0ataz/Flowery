import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';

class CategoryResponseEntity {
  final String message;
  final MetadataEntity metadata;
  final List<CategoryEntity> categories;

  CategoryResponseEntity({
    required this.message,
    required this.metadata,
    required this.categories,
  });
}
