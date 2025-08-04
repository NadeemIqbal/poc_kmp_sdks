import Foundation
import SharedSDK

/// ViewModel for the Home view
/// Manages UI state and business logic for displaying users and products
@MainActor
class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let sharedSDK = SharedSDK()
    
    init() {
        // Initialize SDK with iOS-specific services
        let platformServices = IOSPlatformServices()
        // Note: In a real implementation, you would pass the platform services to the SDK
        sharedSDK.initialize()
    }
    
    /// Loads users and products from the shared SDK
    func loadData() {
        Task {
            isLoading = true
            error = nil
            
            do {
                // Load users and products concurrently
                async let usersResult = sharedSDK.getUsers()
                async let productsResult = sharedSDK.getProducts()
                
                let (fetchedUsers, fetchedProducts) = try await (usersResult, productsResult)
                
                users = fetchedUsers
                products = fetchedProducts
                isLoading = false
            } catch {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }
    
    /// Searches users by name
    func searchUsers(query: String) {
        Task {
            do {
                let searchResults = try await sharedSDK.searchUsers(query: query)
                users = searchResults
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    /// Searches products by title/description
    func searchProducts(query: String) {
        Task {
            do {
                let searchResults = try await sharedSDK.searchProducts(query: query)
                products = searchResults
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    /// Clears the current error
    func clearError() {
        error = nil
    }
    
    /// Navigates to user details using the shared SDK
    func navigateToUserDetails(userId: String) {
        sharedSDK.navigateToUserDetails(userId: userId)
    }
    
    /// Navigates to product details using the shared SDK
    func navigateToProductDetails(productId: String) {
        sharedSDK.navigateToProductDetails(productId: productId)
    }
}