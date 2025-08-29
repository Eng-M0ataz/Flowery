import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ListViewsShimmerWidget extends StatelessWidget {
  const ListViewsShimmerWidget({
    super.key,
    this.isCategorie = false,
  });
  final bool isCategorie;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isCategorie ? 93 : 185,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 12,

        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Shimmer(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isCategorie ? 64 : 131,
                height: isCategorie ? 64 : 151,
                decoration: BoxDecoration(
                  color: const Color(0xffebebf4),
                  borderRadius: isCategorie ? BorderRadius.circular(100) : null,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: isCategorie ? 64 : 80,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xffebebf4),
                  borderRadius: BorderRadius.circular(100),
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.paddingMd_10,
        ),
      ),
    );
  }
}
