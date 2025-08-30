import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/best_seller_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/useCases/best_seller_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/meta_data_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/useCases/get_all_occasion_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../../bestSellerTest/best_seller_feature_test.mocks.dart';
import '../../../../../occasion/presentation/viewModels/occasion_view_model_test.mocks.dart';
import '../../../categoriesFeature/presentation/viewModel/viewModel/categories_view_model_test.mocks.dart';

@GenerateMocks([
  GetAllOccasionUseCase,
  BestSellerUseCase,
  CategoriesUseCase,
])
void main() {
  late HomeViewModel homeViewModel;
  late MockGetAllOccasionUseCase getAllOccasionUseCase;
  late MockBestSellerUseCase bestSellerUseCase;
  late MockCategoriesUseCase categoriesUseCase;
  late CategoryResponseEntity categoryResponseEntity;
  late List<CategoryEntity> categoryEntity;
  late ApiResult<CategoryResponseEntity> catResult;
  late ApiResult<BestSellerResponseEntity> bestResult;
  late BestSellerResponseEntity bestSellerResponseEntity;
  late List<BestSellerEntity> bestSallerEntity;
  late ApiResult<OccasionResponseEntity> occasionResponse;
  late OccasionResponseEntity occasionResponseEntity;
  late List<OccasionEntity> occasions;

  setUpAll(
    () {
      getAllOccasionUseCase = MockGetAllOccasionUseCase();
      bestSellerUseCase = MockBestSellerUseCase();
      categoriesUseCase = MockCategoriesUseCase();
      homeViewModel = HomeViewModel(
        getAllOccasionUseCase,
        bestSellerUseCase,
        categoriesUseCase,
      );
      categoryEntity = [
        CategoryEntity(
          id: '1',
          image: 'image1',
          name: 'name1',
          productsCount: 1,
        ),
        CategoryEntity(
          id: '2',
          image: 'image2',
          name: 'name2',
          productsCount: 2,
        ),
      ];
      categoryResponseEntity = CategoryResponseEntity(
        message: 'message',
        metadata: CatMetadataEntity(
          currentPage: 1,
          limit: 1,
          totalPages: 1,
          totalItems: 10,
        ),
        categories: categoryEntity,
      );
      catResult = ApiSuccessResult<CategoryResponseEntity>(
        data: categoryResponseEntity,
      );
      bestSallerEntity = [
        BestSellerEntity(
          Id: '1',
          title: 'title1',
          description: 'description1',
          imgCover: 'imgCover1',
          price: 10,
          priceAfterDiscount: 5,
        ),
        BestSellerEntity(
          Id: '1',
          title: 'title1',
          description: 'description1',
          imgCover: 'imgCover1',
          price: 10,
          priceAfterDiscount: 5,
        )
      ];
      bestSellerResponseEntity = BestSellerResponseEntity(
        message: 'message',
        bestSeller: bestSallerEntity,
      );
      bestResult = ApiSuccessResult<BestSellerResponseEntity>(
        data: bestSellerResponseEntity,
      );
      occasions = [
        OccasionEntity(
            id: 'id1', name: 'name1', slug: 'slug1', image: 'image1'),
        OccasionEntity(
            id: 'id2', name: 'name2', slug: 'slug2', image: 'image2'),
      ];
      occasionResponseEntity = OccasionResponseEntity(
        message: 'message',
        metadata: MetadataEntity(
            currentPage: 1, limit: 1, totalItems: 1, totalPages: 1),
        occasions: occasions,
      );
      occasionResponse = ApiSuccessResult<OccasionResponseEntity>(
        data: occasionResponseEntity,
      );
    },
  );
  group(
    'Home View Model Test',
    () {
      blocTest<HomeViewModel, HomeState>(
        'test final state only',
        build: () => homeViewModel,
        act: (homeViewModel) {
          provideDummy<ApiResult<CategoryResponseEntity>>(catResult);
          when(categoriesUseCase.invoke()).thenAnswer((_) async => catResult);

          provideDummy<ApiResult<BestSellerResponseEntity>>(bestResult);
          when(bestSellerUseCase.invoke()).thenAnswer((_) async => bestResult);

          provideDummy<ApiResult<OccasionResponseEntity>>(occasionResponse);
          when(getAllOccasionUseCase.invoke())
              .thenAnswer((_) async => occasionResponse);
          homeViewModel.doIntent(GetAllHome());
        },
        skip: 2,
        expect: () => [
          homeViewModel.state.copyWith(
            isBestSallerLoading: false,
            bestSallerList: bestSallerEntity,
            bestSallerFailure: null,
            isOccasionLoading: false,
            occasionsList: occasions,
            occasionFailure: null,
            isCategoriesLoading: false,
            categoriesList: categoryEntity,
            categoriesFailure: null,
          ),
        ],
        verify: (homeViewModel) {
          verify(getAllOccasionUseCase.invoke()).called(1);
          verify(bestSellerUseCase.invoke()).called(1);
          verify(categoriesUseCase.invoke()).called(1);
        },
      );
    },
  );
}
