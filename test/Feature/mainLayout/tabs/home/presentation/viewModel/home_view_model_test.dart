import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

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
          createdAt: DateTime.now(),
          id: '1',
          image: 'image1',
          isSuperAdmin: true,
          name: 'name1',
          productsCount: 1,
          slug: 'slug1',
          updatedAt: DateTime.now(),
        ),
        CategoryEntity(
          createdAt: DateTime.now(),
          id: '2',
          image: 'image2',
          isSuperAdmin: true,
          name: 'name2',
          productsCount: 2,
          slug: 'slug2',
          updatedAt: DateTime.now(),
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
          rateAvg: 1,
          rateCount: 1,
          Id: '1',
          title: 'title1',
          slug: 'slug1',
          description: 'description1',
          imgCover: 'imgCover1',
          images: ['image1', 'image2', 'image3'],
          price: 10,
          priceAfterDiscount: 5,
          quantity: 4,
          category: 'category',
          occasion: 'occasion',
          createdAt: 'createdAt',
          updatedAt: 'updatedAt',
          V: 1,
          isSuperAdmin: true,
          sold: 3,
          id: '1',
        ),
        BestSellerEntity(
          rateAvg: 1,
          rateCount: 1,
          Id: '1',
          title: 'title1',
          slug: 'slug1',
          description: 'description1',
          imgCover: 'imgCover1',
          images: ['image1', 'image2', 'image3'],
          price: 10,
          priceAfterDiscount: 5,
          quantity: 4,
          category: 'category',
          occasion: 'occasion',
          createdAt: 'createdAt',
          updatedAt: 'updatedAt',
          V: 1,
          isSuperAdmin: true,
          sold: 3,
          id: '1',
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
