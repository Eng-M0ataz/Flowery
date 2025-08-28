import 'package:equatable/equatable.dart';

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

class GetCategoryProductsEvent extends CategoriesEvent {
  final String categoryId;
  final int? page;
  final int? limit;

  const GetCategoryProductsEvent({
    required this.categoryId,
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [categoryId, page, limit];
}
