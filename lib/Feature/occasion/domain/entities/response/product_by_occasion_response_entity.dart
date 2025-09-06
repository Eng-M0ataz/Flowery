import '../meta_data_entity.dart';
import '../product_entity.dart';

class ProductByOccasionResponseEntity {
  final String? message;
  final MetadataEntity? metadata;
  final List<ProductEntity>? products;

  ProductByOccasionResponseEntity({
    this.message,
    this.metadata,
    this.products,
  });
}
