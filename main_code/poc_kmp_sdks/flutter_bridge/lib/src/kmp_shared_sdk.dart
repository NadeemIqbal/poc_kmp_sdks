import 'models/user.dart';
import 'models/product.dart';
import 'kmp_shared_sdk_platform_interface.dart';

/// Main Flutter SDK class that provides access to all shared functionality
class KmpSharedSdk {
  /// Initialize the SDK
  /// Should be called once during app startup
  Future<void> initialize() {
    return KmpSharedSdkPlatform.instance.initialize();
  }

  // User operations

  /// Gets all users
  Future<List<User>> getUsers() {
    return KmpSharedSdkPlatform.instance.getUsers();
  }

  /// Gets a specific user by ID
  /// Returns null if user is not found
  Future<User?> getUserById(String userId) {
    return KmpSharedSdkPlatform.instance.getUserById(userId);
  }

  /// Searches users by name
  /// Returns empty list if no matches found
  Future<List<User>> searchUsers(String query) {
    return KmpSharedSdkPlatform.instance.searchUsers(query);
  }

  // Product operations

  /// Gets all products
  Future<List<Product>> getProducts() {
    return KmpSharedSdkPlatform.instance.getProducts();
  }

  /// Gets a specific product by ID
  /// Returns null if product is not found
  Future<Product?> getProductById(String productId) {
    return KmpSharedSdkPlatform.instance.getProductById(productId);
  }

  /// Searches products by title or description
  /// Returns empty list if no matches found
  Future<List<Product>> searchProducts(String query) {
    return KmpSharedSdkPlatform.instance.searchProducts(query);
  }

  /// Gets products within a price range
  /// Returns empty list if no products found in range
  Future<List<Product>> getProductsByPriceRange(
    double minPrice,
    double maxPrice,
  ) {
    return KmpSharedSdkPlatform.instance.getProductsByPriceRange(
      minPrice,
      maxPrice,
    );
  }

  // Navigation operations

  /// Navigates to user details screen
  Future<void> navigateToUserDetails(String userId) {
    return KmpSharedSdkPlatform.instance.navigateToUserDetails(userId);
  }

  /// Navigates to product details screen
  Future<void> navigateToProductDetails(String productId) {
    return KmpSharedSdkPlatform.instance.navigateToProductDetails(productId);
  }

  /// Navigates back to the previous screen
  Future<void> navigateBack() {
    return KmpSharedSdkPlatform.instance.navigateBack();
  }

  /// Shows a platform-specific message
  Future<void> showMessage(String message) {
    return KmpSharedSdkPlatform.instance.showMessage(message);
  }

  /// Gets platform information
  Future<String> getPlatformInfo() {
    return KmpSharedSdkPlatform.instance.getPlatformInfo();
  }
}
