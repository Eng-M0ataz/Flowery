class MetadataEntity {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;

  MetadataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });
}