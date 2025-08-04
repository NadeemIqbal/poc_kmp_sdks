import Foundation
import React
import SharedSDK

@objc(KmpSharedSdkRn)
class KmpSharedSdkRn: NSObject {
    private var sharedSDK: SharedSDK!
    
    override init() {
        super.init()
        // Initialize SharedSDK with iOS platform services
        let platformServices = IOSPlatformServices()
        sharedSDK = SharedSDK(platformServices: platformServices, platformNavigator: nil)
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc
    func initialize(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        sharedSDK.initialize()
        resolve(nil)
    }
    
    @objc
    func getUsers(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let users = try await sharedSDK.getUsers()
                let usersArray = users.map { user in
                    [
                        "id": user.id,
                        "name": user.name,
                        "email": user.email
                    ]
                }
                DispatchQueue.main.async {
                    resolve(usersArray)
                }
            } catch {
                DispatchQueue.main.async {
                    reject("GET_USERS_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func getUserById(_ userId: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let user = try await sharedSDK.getUserById(userId: userId)
                if let user = user {
                    let userDict = [
                        "id": user.id,
                        "name": user.name,
                        "email": user.email
                    ]
                    DispatchQueue.main.async {
                        resolve(userDict)
                    }
                } else {
                    DispatchQueue.main.async {
                        resolve(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    reject("GET_USER_BY_ID_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func searchUsers(_ query: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let users = try await sharedSDK.searchUsers(query: query)
                let usersArray = users.map { user in
                    [
                        "id": user.id,
                        "name": user.name,
                        "email": user.email
                    ]
                }
                DispatchQueue.main.async {
                    resolve(usersArray)
                }
            } catch {
                DispatchQueue.main.async {
                    reject("SEARCH_USERS_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func getProducts(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let products = try await sharedSDK.getProducts()
                let productsArray = products.map { product in
                    [
                        "id": product.id,
                        "title": product.title,
                        "description": product.description,
                        "price": product.price
                    ]
                }
                DispatchQueue.main.async {
                    resolve(productsArray)
                }
            } catch {
                DispatchQueue.main.async {
                    reject("GET_PRODUCTS_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func getProductById(_ productId: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let product = try await sharedSDK.getProductById(productId: productId)
                if let product = product {
                    let productDict = [
                        "id": product.id,
                        "title": product.title,
                        "description": product.description,
                        "price": product.price
                    ] as [String : Any]
                    DispatchQueue.main.async {
                        resolve(productDict)
                    }
                } else {
                    DispatchQueue.main.async {
                        resolve(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    reject("GET_PRODUCT_BY_ID_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func searchProducts(_ query: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let products = try await sharedSDK.searchProducts(query: query)
                let productsArray = products.map { product in
                    [
                        "id": product.id,
                        "title": product.title,
                        "description": product.description,
                        "price": product.price
                    ] as [String : Any]
                }
                DispatchQueue.main.async {
                    resolve(productsArray)
                }
            } catch {
                DispatchQueue.main.async {
                    reject("SEARCH_PRODUCTS_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func getProductsByPriceRange(_ minPrice: Double, maxPrice: Double, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let products = try await sharedSDK.getProductsByPriceRange(minPrice: minPrice, maxPrice: maxPrice)
                let productsArray = products.map { product in
                    [
                        "id": product.id,
                        "title": product.title,
                        "description": product.description,
                        "price": product.price
                    ] as [String : Any]
                }
                DispatchQueue.main.async {
                    resolve(productsArray)
                }
            } catch {
                DispatchQueue.main.async {
                    reject("GET_PRODUCTS_BY_PRICE_RANGE_ERROR", error.localizedDescription, error)
                }
            }
        }
    }
    
    @objc
    func navigateToUserDetails(_ userId: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        sharedSDK.navigateToUserDetails(userId: userId)
        resolve(nil)
    }
    
    @objc
    func navigateToProductDetails(_ productId: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        sharedSDK.navigateToProductDetails(productId: productId)
        resolve(nil)
    }
    
    @objc
    func navigateBack(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        sharedSDK.navigateBack()
        resolve(nil)
    }
    
    @objc
    func showMessage(_ message: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        sharedSDK.showMessage(message: message)
        resolve(nil)
    }
    
    @objc
    func getPlatformInfo(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        let platformInfo = sharedSDK.getPlatformInfo()
        resolve(platformInfo)
    }
}