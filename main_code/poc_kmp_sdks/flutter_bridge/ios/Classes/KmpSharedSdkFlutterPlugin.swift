import Flutter
import UIKit
import SharedSDK

public class KmpSharedSdkFlutterPlugin: NSObject, FlutterPlugin {
    private var sharedSDK: SharedSDK!
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "kmp_shared_sdk_flutter", binaryMessenger: registrar.messenger())
        let instance = KmpSharedSdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // Initialize SharedSDK with iOS platform services
        let platformServices = IOSPlatformServices()
        instance.sharedSDK = SharedSDK(platformServices: platformServices, platformNavigator: nil)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            sharedSDK.initialize()
            result(nil)
            
        case "getUsers":
            Task {
                do {
                    let users = try await sharedSDK.getUsers()
                    let usersJson = users.map { user in
                        [
                            "id": user.id,
                            "name": user.name,
                            "email": user.email
                        ]
                    }
                    DispatchQueue.main.async {
                        result(usersJson)
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "GET_USERS_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "getUserById":
            guard let arguments = call.arguments as? [String: Any],
                  let userId = arguments["userId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "userId is required", details: nil))
                return
            }
            
            Task {
                do {
                    let user = try await sharedSDK.getUserById(userId: userId)
                    if let user = user {
                        let userJson = [
                            "id": user.id,
                            "name": user.name,
                            "email": user.email
                        ]
                        DispatchQueue.main.async {
                            result(userJson)
                        }
                    } else {
                        DispatchQueue.main.async {
                            result(nil)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "GET_USER_BY_ID_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "searchUsers":
            let arguments = call.arguments as? [String: Any]
            let query = arguments?["query"] as? String ?? ""
            
            Task {
                do {
                    let users = try await sharedSDK.searchUsers(query: query)
                    let usersJson = users.map { user in
                        [
                            "id": user.id,
                            "name": user.name,
                            "email": user.email
                        ]
                    }
                    DispatchQueue.main.async {
                        result(usersJson)
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "SEARCH_USERS_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "getProducts":
            Task {
                do {
                    let products = try await sharedSDK.getProducts()
                    let productsJson = products.map { product in
                        [
                            "id": product.id,
                            "title": product.title,
                            "description": product.description,
                            "price": product.price
                        ]
                    }
                    DispatchQueue.main.async {
                        result(productsJson)
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "GET_PRODUCTS_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "getProductById":
            guard let arguments = call.arguments as? [String: Any],
                  let productId = arguments["productId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "productId is required", details: nil))
                return
            }
            
            Task {
                do {
                    let product = try await sharedSDK.getProductById(productId: productId)
                    if let product = product {
                        let productJson = [
                            "id": product.id,
                            "title": product.title,
                            "description": product.description,
                            "price": product.price
                        ]
                        DispatchQueue.main.async {
                            result(productJson)
                        }
                    } else {
                        DispatchQueue.main.async {
                            result(nil)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "GET_PRODUCT_BY_ID_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "searchProducts":
            let arguments = call.arguments as? [String: Any]
            let query = arguments?["query"] as? String ?? ""
            
            Task {
                do {
                    let products = try await sharedSDK.searchProducts(query: query)
                    let productsJson = products.map { product in
                        [
                            "id": product.id,
                            "title": product.title,
                            "description": product.description,
                            "price": product.price
                        ]
                    }
                    DispatchQueue.main.async {
                        result(productsJson)
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "SEARCH_PRODUCTS_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "getProductsByPriceRange":
            guard let arguments = call.arguments as? [String: Any],
                  let minPrice = arguments["minPrice"] as? Double,
                  let maxPrice = arguments["maxPrice"] as? Double else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "minPrice and maxPrice are required", details: nil))
                return
            }
            
            Task {
                do {
                    let products = try await sharedSDK.getProductsByPriceRange(minPrice: minPrice, maxPrice: maxPrice)
                    let productsJson = products.map { product in
                        [
                            "id": product.id,
                            "title": product.title,
                            "description": product.description,
                            "price": product.price
                        ]
                    }
                    DispatchQueue.main.async {
                        result(productsJson)
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "GET_PRODUCTS_BY_PRICE_RANGE_ERROR", message: error.localizedDescription, details: nil))
                    }
                }
            }
            
        case "navigateToUserDetails":
            guard let arguments = call.arguments as? [String: Any],
                  let userId = arguments["userId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "userId is required", details: nil))
                return
            }
            
            sharedSDK.navigateToUserDetails(userId: userId)
            result(nil)
            
        case "navigateToProductDetails":
            guard let arguments = call.arguments as? [String: Any],
                  let productId = arguments["productId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "productId is required", details: nil))
                return
            }
            
            sharedSDK.navigateToProductDetails(productId: productId)
            result(nil)
            
        case "navigateBack":
            sharedSDK.navigateBack()
            result(nil)
            
        case "showMessage":
            guard let arguments = call.arguments as? [String: Any],
                  let message = arguments["message"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "message is required", details: nil))
                return
            }
            
            sharedSDK.showMessage(message: message)
            result(nil)
            
        case "getPlatformInfo":
            let platformInfo = sharedSDK.getPlatformInfo()
            result(platformInfo)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}