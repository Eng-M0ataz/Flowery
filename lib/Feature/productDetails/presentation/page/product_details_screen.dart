import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/Constantts/sizes.dart';
import '../widgets/custom_image_slide_show.dart';
import '../widgets/product_details_footer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productDetailsModel});

  final ProductDetailsModel productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomImageSlideShow(
                      itemImagesList: productDetailsModel.images ?? [],
                    ),
                    Positioned(
                        top: AppSizes.paddingXl_64,
                        left: AppSizes.paddingMd_16,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new_outlined),
                          onPressed: () {
                            context.pop();
                          },
                        ))
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                ProductDetailsFooter(
                  product: productDetailsModel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
