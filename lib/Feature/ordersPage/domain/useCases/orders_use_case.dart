import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';
import 'package:injectable/injectable.dart';

ProductDetailsModel product = ProductDetailsModel(
  id: "6745096c90ab40a0685402fc",
  title: "Forever Pink | Baby Roses",
  description: "A gift of pink baby roses holds profound meaning. It symbolizes love, gratitude, and appreciation, making it a perfect choice for any occasion. The soft, feminine hue of pink baby roses embodies notions of nurturing and emotional love. They are also a gentle way to express sympathy or convey a message filled with kindness. These pink baby roses represent a significant gesture of love or a heartfelt wish for good luck and happiness. Embrace the power of pink roses to convey your emotions and leave a lasting impression.",
  imageCover: "https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png",
  images: [
    "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
    "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
    "https://flower.elevateegy.com/uploads/3594e620-5411-4c6f-bf4f-188e312ee391-image_three.png",
    "https://flower.elevateegy.com/uploads/8cfb2f72-c8e8-47f6-bf10-70f43b3e0fed-image_two.png"
  ],
  price: 2049,
  priceAfterDiscount: 1899,
  quantity: 4696,
);

ProductDetailsModel product2 = ProductDetailsModel(
  id: "673e2bd91159920171828139",
  title: "Red Wedding Flower",
  description: "This is a Pack of Red Wedding Flowers",
  imageCover: "https://flower.elevateegy.com/uploads/5452abf4-2040-43d7-bb3d-3ae8f53c4576-cover_image.png",
  images: [
    "https://flower.elevateegy.com/uploads/ba028e59-410f-43ac-aed5-f4f97c102b98-image_four.png",
    "https://flower.elevateegy.com/uploads/f89bc954-eb0d-4efb-928f-6717f77b69ed-image_one.png",
    "https://flower.elevateegy.com/uploads/5ed2d072-485b-4a53-a0fa-a41412791397-image_three.png",
    "https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png"
  ],
  price: 250,
  priceAfterDiscount: 150,
  quantity: 782,
);

List<OrderItems> items = [
  OrderItems(
      id: "68be77fda8bca307f9e2e25c",
      quantity: 2,
      price: 2049,
      product: product
  ),
  OrderItems(
      id: "68be781ba8bca307f9e2e265",
      quantity: 5,
      price: 250,
      product: product2
  ),
];

List<OrderItems> items2 = [
  OrderItems(
      id: "68be781ba8bca307f9e2e265",
      quantity: 5,
      price: 250,
      product: product2
  ),
];

List<OrdersEntity> orders = [OrdersEntity(
    id: "1",
    user: "1",
    orderItems: items,
    totalPrice: 5348,
    paymentType: "Cash",
    isPaid: false,
    isDelivered: false,
    state: "pending",
    orderNumber: "#125429",
    createdAt: "2025-09-08T06:57:05.166Z",
    updatedAt: "2025-09-08T06:57:05.166Z",
  ),
  OrdersEntity(
    id: "2",
    user: "2",
    orderItems: items2,
    totalPrice: 5348,
    paymentType: "Cash",
    isPaid: false,
    isDelivered: true,
    state: "pending",
    orderNumber: "#125429",
    createdAt: "2025-09-08T06:57:05.166Z",
    updatedAt: "2025-09-08T06:57:05.166Z",
  ),
];

@injectable
class OrdersUseCase{
  // final OrdersRepo _ordersRepo;

  Future <ApiResult<OrdersResponseEntity>> invoke() async {
    return ApiSuccessResult(
      data: OrdersResponseEntity(
        message: "success",
        orders: orders,
      ),
    );
  }
}