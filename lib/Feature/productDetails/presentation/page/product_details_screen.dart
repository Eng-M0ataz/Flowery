import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/viewModels/occasion_event.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/viewModels/occasion_state.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/viewModels/occasion_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/Constantts/sizes.dart';
import '../widgets/custom_image_slide_show.dart';
import '../widgets/product_details_footer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productDetailsModel});

  final ProductDetailsModel productDetailsModel;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

late OccasionViewModel _occasionViewModel;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    _occasionViewModel = getIt<OccasionViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    _occasionViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _occasionViewModel,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CustomImageSlideShow(
                        itemImagesList: widget.productDetailsModel.images ?? [],
                      ),
                      Positioned(
                          top: AppSizes.paddingXl_32,
                          left: AppSizes.paddingMd_16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColorsLight.pink,
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadiusFull,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new_outlined),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_16),
                  ProductDetailsFooter(
                    product: widget.productDetailsModel,
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMd_16,
                ),
                child: BlocConsumer<OccasionViewModel, OccasionState>(
                  listener: (context, state) {
                    if (state.addToCartFailure != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColorsLight.pink,
                          duration: Duration(seconds: 1),
                          content: Text(state.addToCartFailure!.errorMessage),
                        ),
                      );
                    }
                    if (state.addToCartResponse != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColorsLight.pink,
                          duration: Duration(seconds: 1),
                          content: Text('Product added to cart successfully'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      widget: Text(LocaleKeys.add_to_cart.tr()),
                      onPressed: widget.productDetailsModel.quantity! <= 0
                          ? null
                          : () {
                              _occasionViewModel.doIntent(AddProductToCartEvent(
                                  productId: widget.productDetailsModel.id
                                      .toString()));
                            },
                      isLoading: state.isAddingToCartLoading,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.spaceBetweenItems_32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
