import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';

class ProductResponseEntity {
  final String? message;
  final MetadataEntity? metadata;
  final List<ProductEntity>? products;

  ProductResponseEntity({
    this.message,
    this.metadata,
    this.products,
  });
}
