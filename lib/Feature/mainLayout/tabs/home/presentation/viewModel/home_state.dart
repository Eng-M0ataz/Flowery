import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import '../../../../../bestSellerFeature/domain/entities/best_seller_entity.dart';

class HomeState extends Equatable {
  final bool isCategoriesLoading;
  final List<CategoryEntity> categoriesList;
  final Failure? categoriesFailure;

  final bool isBestSellerLoading;
  final List<BestSellerEntity> bestSellerList;
  final Failure? bestSellerFailure;

  final bool isOccasionLoading;
  final List<OccasionEntity> occasionsList;
  final Failure? occasionFailure;

  const HomeState({
    this.isCategoriesLoading = true,
    this.categoriesList = const [],
    this.categoriesFailure,
    this.bestSellerList = const [],
    this.bestSellerFailure,
    this.isOccasionLoading = true,
    this.occasionsList = const [],
    this.occasionFailure,
    this.isBestSellerLoading = true,
  });

  HomeState copyWith({
    bool? isCategoriesLoading,
    List<CategoryEntity>? categoriesList,
    Failure? categoriesFailure,
    bool? isBestSellerLoading,
    List<BestSellerEntity>? bestSellerList,
    Failure? bestSellerFailure,
    bool? isOccasionLoading,
    List<OccasionEntity>? occasionsList,
    Failure? occasionFailure,
  }) {
    return HomeState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      categoriesList: categoriesList ?? this.categoriesList,
      categoriesFailure: categoriesFailure ?? this.categoriesFailure,
      isBestSellerLoading: isBestSellerLoading ?? this.isBestSellerLoading,
      bestSellerList: bestSellerList ?? this.bestSellerList,
      bestSellerFailure: bestSellerFailure ?? this.bestSellerFailure,
      isOccasionLoading: isOccasionLoading ?? this.isOccasionLoading,
      occasionsList: occasionsList ?? this.occasionsList,
      occasionFailure: occasionFailure ?? this.occasionFailure,
    );
  }

  @override
  List<Object?> get props => [
        isBestSellerLoading,
        bestSellerList,
        bestSellerFailure,
        isCategoriesLoading,
        categoriesList,
        categoriesFailure,
        isOccasionLoading,
        occasionsList,
        occasionFailure,
      ];
}
