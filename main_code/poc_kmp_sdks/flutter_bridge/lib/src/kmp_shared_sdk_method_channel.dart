import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'models/user.dart';
import 'models/product.dart';
import 'kmp_shared_sdk_platform_interface.dart';

/// Method channel implementation of [KmpSharedSdkPlatform]
class MethodChannelKmpSharedSdk extends KmpSharedSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kmp_shared_sdk_flutter');

  @override
  Future<void> initialize() async {
    await methodChannel.invokeMethod<void>('initialize');
  }

  @override
  Future<List<User>> getUsers() async {
    final List<dynamic>? result = await methodChannel
        .invokeMethod<List<dynamic>>('getUsers');
    if (result == null) return [];

    return result
        .map((json) => User.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<User?> getUserById(String userId) async {
    final Map<dynamic, dynamic>? result = await methodChannel
        .invokeMethod<Map<dynamic, dynamic>>('getUserById', {'userId': userId});

    if (result == null) return null;
    return User.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    final List<dynamic>? result = await methodChannel
        .invokeMethod<List<dynamic>>('searchUsers', {'query': query});

    if (result == null) return [];
    return result
        .map((json) => User.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<List<Product>> getProducts() async {
    final List<dynamic>? result = await methodChannel
        .invokeMethod<List<dynamic>>('getProducts');
    if (result == null) return [];

    return result
        .map((json) => Product.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<Product?> getProductById(String productId) async {
    final Map<dynamic, dynamic>? result = await methodChannel
        .invokeMethod<Map<dynamic, dynamic>>('getProductById', {
          'productId': productId,
        });

    if (result == null) return null;
    return Product.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final List<dynamic>? result = await methodChannel
        .invokeMethod<List<dynamic>>('searchProducts', {'query': query});

    if (result == null) return [];
    return result
        .map((json) => Product.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<List<Product>> getProductsByPriceRange(
    double minPrice,
    double maxPrice,
  ) async {
    final List<dynamic>? result = await methodChannel
        .invokeMethod<List<dynamic>>('getProductsByPriceRange', {
          'minPrice': minPrice,
          'maxPrice': maxPrice,
        });

    if (result == null) return [];
    return result
        .map((json) => Product.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<void> navigateToUserDetails(String userId) async {
    await methodChannel.invokeMethod<void>('navigateToUserDetails', {
      'userId': userId,
    });
  }

  @override
  Future<void> navigateToProductDetails(String productId) async {
    await methodChannel.invokeMethod<void>('navigateToProductDetails', {
      'productId': productId,
    });
  }

  @override
  Future<void> navigateBack() async {
    await methodChannel.invokeMethod<void>('navigateBack');
  }

  @override
  Future<void> showMessage(String message) async {
    await methodChannel.invokeMethod<void>('showMessage', {'message': message});
  }

  @override
  Future<String> getPlatformInfo() async {
    final String? result = await methodChannel.invokeMethod<String>(
      'getPlatformInfo',
    );
    return result ?? 'Unknown Platform';
  }
}
