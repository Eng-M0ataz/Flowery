import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_product_card.dart';

void main() {
  group('ProductCard Widget Tests', () {
    testWidgets('should display product information correctly', (tester) async {
      // Arrange
      bool addToCartPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(
              imgCover: 'https://example.com/image.jpg',
              title: 'Test Product',
              price: 100,
              priceAfterDiscount: 80,
              discountPercent: 20,
              onAddToCart: () {
                addToCartPressed = true;
              },
            ),
          ),
        ),
      );

      // Act & Assert
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('80'), findsOneWidget); // Price after discount
      expect(find.text('100'), findsOneWidget); // Original price
      expect(find.text('20%'), findsOneWidget); // Discount percentage
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Test button press
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(addToCartPressed, isTrue);
    });

    testWidgets('should handle long product titles with ellipsis', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(
              imgCover: 'https://example.com/image.jpg',
              title: 'This is a very long product title that should be truncated',
              price: 100,
              priceAfterDiscount: 80,
              discountPercent: 20,
              onAddToCart: () {},
            ),
          ),
        ),
      );

      // Act & Assert
      final titleWidget = tester.widget<Text>(
          find.text('This is a very long product title that should be truncated')
      );
      expect(titleWidget.overflow, equals(TextOverflow.ellipsis));
      expect(titleWidget.maxLines, equals(1));
    });
  });
}