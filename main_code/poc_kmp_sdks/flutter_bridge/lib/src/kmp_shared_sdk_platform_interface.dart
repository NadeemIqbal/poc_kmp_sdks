// Note: plugin_platform_interface should be added to pubspec.yaml dependencies
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'models/user.dart';
import 'models/product.dart';
import 'kmp_shared_sdk_method_channel.dart';

/// Platform interface for the KMP Shared SDK
abstract class KmpSharedSdkPlatform {
  static KmpSharedSdkPlatform _instance = MethodChannelKmpSharedSdk();

  /// The default instance of [KmpSharedSdkPlatform] to use.
  static KmpSharedSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KmpSharedSdkPlatform] when
  /// they register themselves.
  static set instance(KmpSharedSdkPlatform instance) {
    _instance = instance;
  }

  /// Initialize the SDK
  Future<void> initialize() {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Get all users
  Future<List<User>> getUsers() {
    throw UnimplementedError('getUsers() has not been implemented.');
  }

  /// Get user by ID
  Future<User?> getUserById(String userId) {
    throw UnimplementedError('getUserById() has not been implemented.');
  }

  /// Search users by name
  Future<List<User>> searchUsers(String query) {
    throw UnimplementedError('searchUsers() has not been implemented.');
  }

  /// Get all products
  Future<List<Product>> getProducts() {
    throw UnimplementedError('getProducts() has not been implemented.');
  }

  /// Get product by ID
  Future<Product?> getProductById(String productId) {
    throw UnimplementedError('getProductById() has not been implemented.');
  }

  /// Search products
  Future<List<Product>> searchProducts(String query) {
    throw UnimplementedError('searchProducts() has not been implemented.');
  }

  /// Get products by price range
  Future<List<Product>> getProductsByPriceRange(
    double minPrice,
    double maxPrice,
  ) {
    throw UnimplementedError(
      'getProductsByPriceRange() has not been implemented.',
    );
  }

  /// Navigate to user details
  Future<void> navigateToUserDetails(String userId) {
    throw UnimplementedError(
      'navigateToUserDetails() has not been implemented.',
    );
  }

  /// Navigate to product details
  Future<void> navigateToProductDetails(String productId) {
    throw UnimplementedError(
      'navigateToProductDetails() has not been implemented.',
    );
  }

  /// Navigate back
  Future<void> navigateBack() {
    throw UnimplementedError('navigateBack() has not been implemented.');
  }

  /// Show message
  Future<void> showMessage(String message) {
    throw UnimplementedError('showMessage() has not been implemented.');
  }

  /// Get platform info
  Future<String> getPlatformInfo() {
    throw UnimplementedError('getPlatformInfo() has not been implemented.');
  }
}
