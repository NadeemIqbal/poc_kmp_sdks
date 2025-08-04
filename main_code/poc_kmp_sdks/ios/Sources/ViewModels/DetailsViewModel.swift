import Foundation
import SharedSDK

/// ViewModel for the Details view
/// Manages UI state and business logic for displaying individual item details
@MainActor
class DetailsViewModel: ObservableObject {
    @Published var user: User?
    @Published var product: Product?
    @Published var isLoading = false
    @Published var error: String?
    
    private let sharedSDK = SharedSDK()
    
    /// Loads an item (user or product) by ID and type
    func loadItem(itemId: String, itemType: DetailsView.ItemType) {
        Task {
            isLoading = true
            error = nil
            user = nil
            product = nil
            
            do {
                switch itemType {
                case .user:
                    let fetchedUser = try await sharedSDK.getUserById(userId: itemId)
                    if let fetchedUser = fetchedUser {
                        user = fetchedUser
                    } else {
                        error = "User not found"
                    }
                    
                case .product:
                    let fetchedProduct = try await sharedSDK.getProductById(productId: itemId)
                    if let fetchedProduct = fetchedProduct {
                        product = fetchedProduct
                    } else {
                        error = "Product not found"
                    }
                }
                
                isLoading = false
            } catch {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }
    
    /// Navigates back using the shared SDK
    func navigateBack() {
        sharedSDK.navigateBack()
    }
}