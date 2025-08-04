package org.nadeem.project.rn_bridge

import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import main_code.SharedSDK
import main_code.platform.AndroidPlatformServices

class KmpSharedSdkRnModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  private val sharedSDK: SharedSDK
  private val coroutineScope = CoroutineScope(Dispatchers.Main)

  init {
    // Initialize SharedSDK with Android platform services
    val platformServices = AndroidPlatformServices(reactContext)
    sharedSDK = SharedSDK(platformServices)
  }

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun initialize(promise: Promise) {
    try {
      sharedSDK.initialize()
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject("INITIALIZE_ERROR", e.message, e)
    }
  }

  @ReactMethod
  fun getUsers(promise: Promise) {
    coroutineScope.launch {
      try {
        val users = sharedSDK.getUsers()
        val usersArray = Arguments.createArray()
        
        users.forEach { user ->
          val userMap = Arguments.createMap().apply {
            putString("id", user.id)
            putString("name", user.name)
            putString("email", user.email)
          }
          usersArray.pushMap(userMap)
        }
        
        promise.resolve(usersArray)
      } catch (e: Exception) {
        promise.reject("GET_USERS_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun getUserById(userId: String, promise: Promise) {
    coroutineScope.launch {
      try {
        val user = sharedSDK.getUserById(userId)
        if (user != null) {
          val userMap = Arguments.createMap().apply {
            putString("id", user.id)
            putString("name", user.name)
            putString("email", user.email)
          }
          promise.resolve(userMap)
        } else {
          promise.resolve(null)
        }
      } catch (e: Exception) {
        promise.reject("GET_USER_BY_ID_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun searchUsers(query: String, promise: Promise) {
    coroutineScope.launch {
      try {
        val users = sharedSDK.searchUsers(query)
        val usersArray = Arguments.createArray()
        
        users.forEach { user ->
          val userMap = Arguments.createMap().apply {
            putString("id", user.id)
            putString("name", user.name)
            putString("email", user.email)
          }
          usersArray.pushMap(userMap)
        }
        
        promise.resolve(usersArray)
      } catch (e: Exception) {
        promise.reject("SEARCH_USERS_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun getProducts(promise: Promise) {
    coroutineScope.launch {
      try {
        val products = sharedSDK.getProducts()
        val productsArray = Arguments.createArray()
        
        products.forEach { product ->
          val productMap = Arguments.createMap().apply {
            putString("id", product.id)
            putString("title", product.title)
            putString("description", product.description)
            putDouble("price", product.price)
          }
          productsArray.pushMap(productMap)
        }
        
        promise.resolve(productsArray)
      } catch (e: Exception) {
        promise.reject("GET_PRODUCTS_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun getProductById(productId: String, promise: Promise) {
    coroutineScope.launch {
      try {
        val product = sharedSDK.getProductById(productId)
        if (product != null) {
          val productMap = Arguments.createMap().apply {
            putString("id", product.id)
            putString("title", product.title)
            putString("description", product.description)
            putDouble("price", product.price)
          }
          promise.resolve(productMap)
        } else {
          promise.resolve(null)
        }
      } catch (e: Exception) {
        promise.reject("GET_PRODUCT_BY_ID_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun searchProducts(query: String, promise: Promise) {
    coroutineScope.launch {
      try {
        val products = sharedSDK.searchProducts(query)
        val productsArray = Arguments.createArray()
        
        products.forEach { product ->
          val productMap = Arguments.createMap().apply {
            putString("id", product.id)
            putString("title", product.title)
            putString("description", product.description)
            putDouble("price", product.price)
          }
          productsArray.pushMap(productMap)
        }
        
        promise.resolve(productsArray)
      } catch (e: Exception) {
        promise.reject("SEARCH_PRODUCTS_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun getProductsByPriceRange(minPrice: Double, maxPrice: Double, promise: Promise) {
    coroutineScope.launch {
      try {
        val products = sharedSDK.getProductsByPriceRange(minPrice, maxPrice)
        val productsArray = Arguments.createArray()
        
        products.forEach { product ->
          val productMap = Arguments.createMap().apply {
            putString("id", product.id)
            putString("title", product.title)
            putString("description", product.description)
            putDouble("price", product.price)
          }
          productsArray.pushMap(productMap)
        }
        
        promise.resolve(productsArray)
      } catch (e: Exception) {
        promise.reject("GET_PRODUCTS_BY_PRICE_RANGE_ERROR", e.message, e)
      }
    }
  }

  @ReactMethod
  fun navigateToUserDetails(userId: String, promise: Promise) {
    try {
      sharedSDK.navigateToUserDetails(userId)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject("NAVIGATE_TO_USER_DETAILS_ERROR", e.message, e)
    }
  }

  @ReactMethod
  fun navigateToProductDetails(productId: String, promise: Promise) {
    try {
      sharedSDK.navigateToProductDetails(productId)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject("NAVIGATE_TO_PRODUCT_DETAILS_ERROR", e.message, e)
    }
  }

  @ReactMethod
  fun navigateBack(promise: Promise) {
    try {
      sharedSDK.navigateBack()
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject("NAVIGATE_BACK_ERROR", e.message, e)
    }
  }

  @ReactMethod
  fun showMessage(message: String, promise: Promise) {
    try {
      sharedSDK.showMessage(message)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject("SHOW_MESSAGE_ERROR", e.message, e)
    }
  }

  @ReactMethod
  fun getPlatformInfo(promise: Promise) {
    try {
      val platformInfo = sharedSDK.getPlatformInfo()
      promise.resolve(platformInfo)
    } catch (e: Exception) {
      promise.reject("GET_PLATFORM_INFO_ERROR", e.message, e)
    }
  }

  companion object {
    const val NAME = "KmpSharedSdkRn"
  }
}