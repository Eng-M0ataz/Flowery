import 'package:flower_e_commerce_app/Feature/mainLayout/domain/entities/meta_data_entity.dart';

import '../product_entity.dart';

class ProductByOccasionResponseEntity {
  final String message;
  final MetadataEntity metadata;
  final List<ProductEntity> products;

  ProductByOccasionResponseEntity({
    required this.message,
    required this.metadata,
    required this.products,
  });
}
