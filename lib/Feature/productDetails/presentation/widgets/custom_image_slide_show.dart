import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';


class CustomImageSlideShow extends StatelessWidget {
  final List<String> itemImagesList;

  const CustomImageSlideShow({super.key, required this.itemImagesList});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        height: 400,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorBackgroundColor: AppColorsLight.white[70],
        isLoop: false,
        children: itemImagesList.map((imagePath) {
          return CachedNetworkImage(
            imageUrl: imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
           placeholder: (context,url)=>Center(child: CircularProgressIndicator()),

          );
        }).toList());
  }
}