import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/best_seller_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class HomeState extends Equatable {
  final bool isCategoriesLoading;
  final List<CategoryEntity> categoriesList;
  final Failure? categoriesFailure;

  final bool isBestSallerLoading;
  final List<BestSellerEntity> bestSallerList;
  final Failure? bestSallerFailure;

  final bool isOccasionLoading;
  final List<OccasionEntity> occasionsList;
  final Failure? occasionFailure;

  const HomeState({
    this.isCategoriesLoading = true,
    this.categoriesList = const [],
    this.categoriesFailure,
    this.bestSallerList = const [],
    this.bestSallerFailure,
    this.isOccasionLoading = true,
    this.occasionsList = const [],
    this.occasionFailure,
    this.isBestSallerLoading = true,
  });

  HomeState copyWith({
    bool? isCategoriesLoading,
    List<CategoryEntity>? categoriesList,
    Failure? categoriesFailure,
    bool? isBestSallerLoading,
    List<BestSellerEntity>? bestSallerList,
    Failure? bestSallerFailure,
    bool? isOccasionLoading,
    List<OccasionEntity>? occasionsList,
    Failure? occasionFailure,
  }) {
    return HomeState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      categoriesList: categoriesList ?? this.categoriesList,
      categoriesFailure: categoriesFailure ?? this.categoriesFailure,
      isBestSallerLoading: isBestSallerLoading ?? this.isBestSallerLoading,
      bestSallerList: bestSallerList ?? this.bestSallerList,
      bestSallerFailure: bestSallerFailure ?? this.bestSallerFailure,
      isOccasionLoading: isOccasionLoading ?? this.isOccasionLoading,
      occasionsList: occasionsList ?? this.occasionsList,
      occasionFailure: occasionFailure ?? this.occasionFailure,
    );
  }

  @override
  List<Object?> get props => [
        isBestSallerLoading,
        bestSallerList,
        bestSallerFailure,
        isCategoriesLoading,
        categoriesList,
        categoriesFailure,
        isOccasionLoading,
        occasionsList,
        occasionFailure,
      ];
}
