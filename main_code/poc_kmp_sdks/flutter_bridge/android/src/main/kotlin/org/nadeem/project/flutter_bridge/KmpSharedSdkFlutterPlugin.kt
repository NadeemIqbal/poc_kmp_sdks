package org.nadeem.project.flutter_bridge

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import main_code.SharedSDK
import main_code.platform.AndroidPlatformServices

/** KmpSharedSdkFlutterPlugin */
class KmpSharedSdkFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var sharedSDK: SharedSDK
  private val coroutineScope = CoroutineScope(Dispatchers.Main)

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "kmp_shared_sdk_flutter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    
    // Initialize SharedSDK with Android platform services
    val platformServices = AndroidPlatformServices(context)
    sharedSDK = SharedSDK(platformServices)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "initialize" -> {
        sharedSDK.initialize()
        result.success(null)
      }
      
      "getUsers" -> {
        coroutineScope.launch {
          try {
            val users = sharedSDK.getUsers()
            val usersJson = users.map { user ->
              mapOf(
                "id" to user.id,
                "name" to user.name,
                "email" to user.email
              )
            }
            result.success(usersJson)
          } catch (e: Exception) {
            result.error("GET_USERS_ERROR", e.message, null)
          }
        }
      }
      
      "getUserById" -> {
        val userId = call.argument<String>("userId")
        if (userId == null) {
          result.error("INVALID_ARGUMENT", "userId is required", null)
          return
        }
        
        coroutineScope.launch {
          try {
            val user = sharedSDK.getUserById(userId)
            if (user != null) {
              val userJson = mapOf(
                "id" to user.id,
                "name" to user.name,
                "email" to user.email
              )
              result.success(userJson)
            } else {
              result.success(null)
            }
          } catch (e: Exception) {
            result.error("GET_USER_BY_ID_ERROR", e.message, null)
          }
        }
      }
      
      "searchUsers" -> {
        val query = call.argument<String>("query") ?: ""
        
        coroutineScope.launch {
          try {
            val users = sharedSDK.searchUsers(query)
            val usersJson = users.map { user ->
              mapOf(
                "id" to user.id,
                "name" to user.name,
                "email" to user.email
              )
            }
            result.success(usersJson)
          } catch (e: Exception) {
            result.error("SEARCH_USERS_ERROR", e.message, null)
          }
        }
      }
      
      "getProducts" -> {
        coroutineScope.launch {
          try {
            val products = sharedSDK.getProducts()
            val productsJson = products.map { product ->
              mapOf(
                "id" to product.id,
                "title" to product.title,
                "description" to product.description,
                "price" to product.price
              )
            }
            result.success(productsJson)
          } catch (e: Exception) {
            result.error("GET_PRODUCTS_ERROR", e.message, null)
          }
        }
      }
      
      "getProductById" -> {
        val productId = call.argument<String>("productId")
        if (productId == null) {
          result.error("INVALID_ARGUMENT", "productId is required", null)
          return
        }
        
        coroutineScope.launch {
          try {
            val product = sharedSDK.getProductById(productId)
            if (product != null) {
              val productJson = mapOf(
                "id" to product.id,
                "title" to product.title,
                "description" to product.description,
                "price" to product.price
              )
              result.success(productJson)
            } else {
              result.success(null)
            }
          } catch (e: Exception) {
            result.error("GET_PRODUCT_BY_ID_ERROR", e.message, null)
          }
        }
      }
      
      "searchProducts" -> {
        val query = call.argument<String>("query") ?: ""
        
        coroutineScope.launch {
          try {
            val products = sharedSDK.searchProducts(query)
            val productsJson = products.map { product ->
              mapOf(
                "id" to product.id,
                "title" to product.title,
                "description" to product.description,
                "price" to product.price
              )
            }
            result.success(productsJson)
          } catch (e: Exception) {
            result.error("SEARCH_PRODUCTS_ERROR", e.message, null)
          }
        }
      }
      
      "getProductsByPriceRange" -> {
        val minPrice = call.argument<Double>("minPrice")
        val maxPrice = call.argument<Double>("maxPrice")
        
        if (minPrice == null || maxPrice == null) {
          result.error("INVALID_ARGUMENT", "minPrice and maxPrice are required", null)
          return
        }
        
        coroutineScope.launch {
          try {
            val products = sharedSDK.getProductsByPriceRange(minPrice, maxPrice)
            val productsJson = products.map { product ->
              mapOf(
                "id" to product.id,
                "title" to product.title,
                "description" to product.description,
                "price" to product.price
              )
            }
            result.success(productsJson)
          } catch (e: Exception) {
            result.error("GET_PRODUCTS_BY_PRICE_RANGE_ERROR", e.message, null)
          }
        }
      }
      
      "navigateToUserDetails" -> {
        val userId = call.argument<String>("userId")
        if (userId == null) {
          result.error("INVALID_ARGUMENT", "userId is required", null)
          return
        }
        
        // Navigation not implemented in simplified SDK
        result.success(null)
      }
      
      "navigateToProductDetails" -> {
        val productId = call.argument<String>("productId")
        if (productId == null) {
          result.error("INVALID_ARGUMENT", "productId is required", null)
          return
        }
        
        // Navigation not implemented in simplified SDK
        result.success(null)
      }
      
      "navigateBack" -> {
        // Navigation not implemented in simplified SDK
        result.success(null)
      }
      
      "showMessage" -> {
        val message = call.argument<String>("message")
        if (message == null) {
          result.error("INVALID_ARGUMENT", "message is required", null)
          return
        }
        
        sharedSDK.showMessage(message)
        result.success(null)
      }
      
      "getPlatformInfo" -> {
        val platformInfo = sharedSDK.getPlatformInfo()
        result.success(platformInfo)
      }
      
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}