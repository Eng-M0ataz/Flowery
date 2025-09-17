import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_peoduct_entity.dart';

class SearchResponseEntity {
  final List<SearchProductEntity> products;
  SearchResponseEntity({
    required this.products,
  });
}
