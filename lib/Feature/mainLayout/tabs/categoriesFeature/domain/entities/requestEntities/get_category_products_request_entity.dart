class GetCategoryProductsRequestEntity {
  final String categoryId;
  final int? page;
  final int? limit;

  const GetCategoryProductsRequestEntity({
    required this.categoryId,
    this.page,
    this.limit,
  });
}
