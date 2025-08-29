import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.image,
    required this.imageHigh,
    required this.imageWidth,
  });

  final String image;
  final double imageHigh, imageWidth;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: imageWidth,
      height: imageHigh,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: AppSizes.mdIcon_24,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
