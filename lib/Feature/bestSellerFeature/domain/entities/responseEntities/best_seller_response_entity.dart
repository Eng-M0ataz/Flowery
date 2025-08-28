import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/best_seller_entity.dart';

class BestSellerResponseEntity {
  final String? message;
  final List<BestSellerEntity>? bestSeller;

  BestSellerResponseEntity({
    this.message,
    this.bestSeller,
  });
}