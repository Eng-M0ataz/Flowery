import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/core/Functions/filter.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCategoriesEvent extends CategoriesEvent {
  const GetAllCategoriesEvent();
}

class GetAllProductsEvent extends CategoriesEvent {
  const GetAllProductsEvent();
}

class GetProductsByCategoryEvent extends CategoriesEvent {
  final String categoryId;
  final int? page;
  final int? limit;

  const GetProductsByCategoryEvent({
    required this.categoryId,
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [categoryId, page, limit];
}

class ApplyFilterEvent extends CategoriesEvent {
  final FILTERTYPE? filterType;

  const ApplyFilterEvent(this.filterType);

  @override
  List<Object?> get props => [filterType];
}

class ClearFilterEvent extends CategoriesEvent {
  const ClearFilterEvent();
}

class AddProductToCartEvent extends CategoriesEvent {
  final String productId;

  const AddProductToCartEvent({required this.productId});
}
