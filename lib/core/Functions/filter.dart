enum FilterType {
  newest,
  oldest,
  discount,
  lowestPrice,
  highestPrice,
}

class Filter{

  List<TProductEntity> filterList<TProductEntity>({
    required List<TProductEntity> items,
    required FilterType filter,
    required DateTime Function(TProductEntity) getCreatedAt,
    required int Function(TProductEntity) getPrice,
    required int? Function(TProductEntity) getPriceAfterDiscount,
    required int Function(TProductEntity) getDiscountPercent,
  }) {
    List<TProductEntity> sorted = [...items]; // copy

    switch (filter) {
      case FilterType.newest:
        sorted.sort((a, b) => getCreatedAt(b).compareTo(getCreatedAt(a)));
        break;

      case FilterType.oldest:
        sorted.sort((a, b) => getCreatedAt(a).compareTo(getCreatedAt(b)));
        break;

      case FilterType.discount:
        sorted = sorted.where((p) => getDiscountPercent(p) > 0).toList();
        sorted.sort((a, b) => getDiscountPercent(b).compareTo(getDiscountPercent(a)));
        break;

      case FilterType.lowestPrice:
        sorted.sort((a, b) =>
            (getPriceAfterDiscount(a) ?? getPrice(a)).compareTo(getPriceAfterDiscount(b) ?? getPrice(b)));
        break;

      case FilterType.highestPrice:
        sorted.sort((a, b) =>
            (getPriceAfterDiscount(b) ?? getPrice(b)).compareTo(getPriceAfterDiscount(a) ?? getPrice(a)));
        break;
    }

    return sorted;
  }

}