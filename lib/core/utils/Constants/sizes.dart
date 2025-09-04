import 'package:flower_e_commerce_app/core/utils/Constants/device_type.dart';
import 'package:responsive_framework/responsive_framework.dart';

abstract class AppSizes {
  // padding and margin sizes
  static const double paddingXs_4 = 4.0;
  static const double paddingSm_8 = 8.0;
  static const double paddingSm_12 = 12.0;
  static const double paddingMd_10 = 10.0;
  static const double paddingMd_12 = 12.0;
  static const double paddingMd_16 = 16.0;
  static const double paddingMd_20 = 20.0;
  static const double paddingLg_24 = 24.0;
  static const double paddingXl_32 = 32.0;

  // icon sizes
  static const double xxsIcon_8 = 8.0;
  static const double xsIcon_12 = 12.0;
  static const double smIcon_16 = 16.0;
  static const double mdIcon_24 = 24.0;
  static const double lgIcon_32 = 32.0;
  static const double lgIcon_36 = 36.0;
  static const double lgIcon_64 = 64.0;

  // font sizes
  static const double xxsFont_10 = 10.0;
  static const double xsFont_12 = 12.0;
  static const double xsFont_13 = 13.0;
  static const double smFont_14 = 14.0;
  static const double mdFont_16 = 16.0;
  static const double lgFont_18 = 18.0;
  static const double xlFont_20 = 20.0;
  static const double xxlFont_24 = 24.0;

  // button sizes

  static const double buttonWidthSm_80 = 80;
  static const double buttonHigh = 56;
  static const double buttonHigh_48 = 48;

  static const double buttonRadius = 8;
  static const double buttonWidth = double.infinity;
  static const double buttonHigh_14 = 14;
  static const double buttonHigh_36 = 36;
  static const double buttonHigh_30 = 30;

  // AppBar High

  static const double appBarHigh = 48.0;
  static const double appBarHigh_24 = 24.0;
  static const double appBarElevation = 0.0;
  static const double appBarLeadingWidth = 120.0;

  // Image sizes

  static const double imageHigh = 80.0;
  static const double imageHigh_220 = 220.0;
  static const double imageHighnNavBar_24 = 24.0;
  static const double imageWidthnNavBar_24 = 24.0;

  // Default Spacing Between items
  static const double spaceBetweenItems_2 = 2.0;
  static const double spaceBetweenItems_4 = 4.0;
  static const double spaceBetweenItems_8 = 8.0;
  static const double spaceBetweenItems_10 = 10.0;
  static const double spaceBetweenItems_12 = 12.0;
  static const double spaceBetweenItems_16 = 16.0;
  static const double spaceBetweenItems_24 = 24.0;
  static const double spaceBetweenItems_32 = 32.0;
  static const double spaceBetweenItems_36 = 36.0;
  static const double spaceBetweenItems_40 = 40.0;
  static const double spaceBetweenItems_42 = 42.0;
  static const double spaceBetweenItems_48 = 48.0;
  static const double spaceBetweenItems_50 = 50.0;

  // Default Spacing Between Sections

  static const double spaceBetweenSections_16 = 16.0;

  // Border Radius

  static const double borderRadius0 = 0.0;
  static const double borderRadiusSm_4 = 4.0;
  static const double borderRadiusMd_8 = 8.0;
  static const double borderRadius_10 = 10.0;
  static const double borderRadiusLg_12 = 12.0;
  static const double borderRadiusXl_16 = 16.0;
  static const double borderRadiusXl_20 = 20.0;
  static const double borderRadiusXxl_24 = 24.0;
  static const double borderRadiusXxxl_32 = 32.0;
  static const double borderRadius_40 = 40.0;
  static const double borderRadiusFull = 100.0;

  // Divider Height

  static const double dividerHeight = 1.0;

  // input field

  static const double inputFieldRadius = 12.0;

  // card sizes

  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 4.0;
  static const double cardHeight_229 = 229.0;

  //pin code
  static const int pinCodeLength_6 = 6;
  static const double pinCodeHeight_74 = 74;
  static const double pinCodeWidth_68 = 68;
  static const int pinCodeSpace = 16;
  static const double pinCodeBorderWidth_2 = 2;

  // grid view spacing
  static const double gridSpacing = 16.0;


  //clip radius
  static const double clipHeight_131 = 131;

  //elevation
  static const double cardElevation_0 = 0.0;

  //max lines
  static const int maxLines_1 = 1;
  //size box sizes
  static const double sizedBoxWidth_8 = 8.0;
  static const double sizedBoxWidth_16 = 16.0;
  static const double sizedBoxHeight_8 = 8.0;
  static const double sizedBoxHeight_16 = 16.0;
  static const double sizedBoxHeight_25 = 25.0;
  static const double sizedBoxHeight_30 = 30.0;

  // Tabs shimmer
  static const double tabListHeight = 40.0;
  static const double tabItemWidth = 80.0;
  static const double tabItemHeight = 30.0;
  static const double tabItemBorderRadius = 16.0;
  static const double tabItemSpacing = 8.0;

  // Product shimmer
  static const double productImageHeight = 150.0;
  static const double shimmerLineHeight = 12.0;
  static const double shimmerLineWidthLarge = 100.0;
  static const double shimmerLineWidthSmall = 60.0;
  static const double shimmerCardRadius = 12.0;
  static const double shimmerFullRadius = 100.0;
  static const double shimmerSpacingSmall = 8.0;
  static const double shimmerSpacingXSmall = 6.0;

  //custom elevated button
  static const double customElevatedButtonHeight_24 = 24;
  static const double customElevatedButtonWidth_24 = 24;

  //spacer
  static const double spacerWidth_0 = 0;

  //switch
  static const double switchWidth_42 = 42.0;
  static const double switchHigh_30 = 30.0;

  // svg pic
  static const double photoHeight_32=32.0;
  static const double photoWidth_32=32.0;
  static const double photoHeight_20=20.0;
  static const double photoWidth_20=20.0;

 //container
  static const double containerHeight_16=16.0;
  static const double containerHeight_20=20.0;
  static const double containerWidth_80=80.0;
  static const double containerWidth_120=120.0;


  // break points

  static const List<Breakpoint> appBreakPoints = [
    Breakpoint(start: 0, end: 450, name: DeviceType.mobile),
    Breakpoint(start: 451, end: 800, name: DeviceType.tablet),
    Breakpoint(start: 801, end: 1920, name: DeviceType.desktop),
  ];
  static const List<Breakpoint> appLandscapeBreakPoints = [
    Breakpoint(start: 0, end: 1023, name: DeviceType.mobile),
    Breakpoint(start: 1024, end: 1599, name: DeviceType.tablet),
    Breakpoint(start: 1600, end: double.infinity, name: DeviceType.desktop),
  ];

  static const double homeBestSellerImageHigh = 151.0;
  static const double homeBestSellerImageWidth = 131.0;
  static const double homeBestSellerTextWidthConstrain = 131.0;
  static const double homeBestSellerListViewHigh = 208.0;

  static const double homeOccasionImageHigh = 151.0;
  static const double homeOccasionImageWidth = 131.0;
  static const double homeOccasionTextWidthConstrain = 131.0;
  static const double homeOccasionListViewHigh = 185.0;

  static const double homeCategoriesImageContainerHigh = 64.0;
  static const double homeCategoriesImageContainerWidth = 64.0;
  static const double homeCategoriesImageHigh = 24.0;
  static const double homeCategoriesImageWidth = 24.0;
  static const double homeCategoriesTextWidthConstrain = 131.0;
  static const double homeCategoriesListViewHigh = 93.0;
  static const int homeDummyShimmerListViewItemsLength = 6;
  static const double homeDummyShimmerListViewTextWidth = 80.0;
  static const double homeDummyShimmerListViewTextHigh = 12.0;
}
