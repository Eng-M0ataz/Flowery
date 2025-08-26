sealed class CategoriesEvent {}

class GetAllCategoriesEvent extends CategoriesEvent {}

class GetCategoryProductsEvent extends CategoriesEvent {
  final String categoryId;
  final int? page;
  final int? limit;

  GetCategoryProductsEvent({
    required this.categoryId,
    this.page,
    this.limit,
  });
}
