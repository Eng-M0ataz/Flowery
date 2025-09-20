int calculateDiscountPercent({
  required int? price,
  required int? priceAfterDiscount,
}) {
  if (price != null && price > 0) {
    return ((1 - ((priceAfterDiscount ?? 0) / price)) * 100).round();
  }
  return 0;
}
