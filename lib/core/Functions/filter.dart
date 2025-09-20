enum FILTERTYPE {
  newest,
  oldest,
  discount,
  lowestPrice,
  highestPrice,
}

class Filter{

  List<TProductEntity> filterList<TProductEntity>({
    required List<TProductEntity> items,
    required FILTERTYPE filter,
    required DateTime Function(TProductEntity) getCreatedAt,
    required int Function(TProductEntity) getPrice,
    required int? Function(TProductEntity) getPriceAfterDiscount,
    required int Function(TProductEntity) getDiscountPercent,
  }) {
    List<TProductEntity> sorted = [...items]; 

    switch (filter) {
      case FILTERTYPE.newest:
        sorted.sort((a, b) => getCreatedAt(b).compareTo(getCreatedAt(a)));
        break;

      case FILTERTYPE.oldest:
        sorted.sort((a, b) => getCreatedAt(a).compareTo(getCreatedAt(b)));
        break;

      case FILTERTYPE.discount:
        sorted = sorted.where((p) => getDiscountPercent(p) > 0).toList();
        sorted.sort((a, b) => getDiscountPercent(b).compareTo(getDiscountPercent(a)));
        break;

      case FILTERTYPE.lowestPrice:
        sorted.sort((a, b) =>
            (getPriceAfterDiscount(a) ?? getPrice(a)).compareTo(getPriceAfterDiscount(b) ?? getPrice(b)));
        break;

      case FILTERTYPE.highestPrice:
        sorted.sort((a, b) =>
            (getPriceAfterDiscount(b) ?? getPrice(b)).compareTo(getPriceAfterDiscount(a) ?? getPrice(a)));
        break;
    }

    return sorted;
  }

}