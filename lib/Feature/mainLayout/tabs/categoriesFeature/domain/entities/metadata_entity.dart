class CatMetadataEntity {
  final int currentPage;
  final int limit;
  final int totalPages;
  final int totalItems;

  CatMetadataEntity({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });
}
