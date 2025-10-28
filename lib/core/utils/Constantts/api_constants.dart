abstract class ApiConstants {
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String signIn = 'auth/signin';
  static const String token = 'token';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String bearer = 'Bearer';
  static const String authorization = 'Authorization';
  static const String editProfile = 'auth/editProfile';
  static const String getLoggedUserData = 'auth/profile-data';
  static const String uploadPhoto = '/auth/upload-photo';
  static const String occasions = 'occasions';
  static const String products = 'products';
  static const String occasionQuery = 'occasion';
  static const String allCategories = 'categories';
  static const String getProducts = 'products';
  static const String categoryQuery = 'category';
  static const String mostSelling = 'best-seller';
  static const String addresses = 'addresses';
  static const String addressById = "addresses/{id}";
  static const String id = "id";
  static const String addToCart = 'cart';
  static const String searchProducts = 'products';
  static const String keywordQuery = 'keyword';
  static const String forgotPassword = 'auth/forgotPassword';
  static const String verifyResetCode = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
  static const String signUp = 'auth/signup';
  static const String orders = 'orders';
  static const String getAndClearUserCart = 'cart';
  static const String removeAndUpdateSpesificUserCartItem = 'cart/{productId}';
  static const String googleDirectionsBaseUrl =
      'https://routes.googleapis.com/directions/v2:';
  static const String computeRoutes = 'computeRoutes';
  static const String xGoogApiKey = 'X-Goog-Api-Key';
  static const String xGoogFieldMask = 'X-Goog-FieldMask';
  static const String cashOrder = 'orders';
  static const String visaOrder = 'orders/checkout?url=http://localhost:3000';
  static const String changePassword = 'auth/change-password';

}
