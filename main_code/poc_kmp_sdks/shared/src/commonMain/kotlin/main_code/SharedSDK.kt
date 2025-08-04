package main_code

import main_code.data.Product
import main_code.data.User
import main_code.domain.GetProductByIdUseCase
import main_code.domain.GetProductsUseCase
import main_code.domain.GetUserByIdUseCase
import main_code.domain.GetUsersUseCase
import main_code.platform.PlatformNavigator
import main_code.platform.PlatformServices
import main_code.repository.FakeProductRepository
import main_code.repository.FakeUserRepository
import main_code.repository.ProductRepository
import main_code.repository.UserRepository

/**
 * Main SDK facade that provides access to all shared functionality
 * This is the primary entry point for platform-specific implementations
 */
class SharedSDK(
    private val platformServices: PlatformServices? = null,
    private val platformNavigator: PlatformNavigator? = null
) {
    
    // Repositories - using fake implementations for now
    private val userRepository: UserRepository = FakeUserRepository()
    private val productRepository: ProductRepository = FakeProductRepository()
    
    // Use cases
    private val getUsersUseCase = GetUsersUseCase(userRepository)
    private val getUserByIdUseCase = GetUserByIdUseCase(userRepository)
    private val getProductsUseCase = GetProductsUseCase(productRepository)
    private val getProductByIdUseCase = GetProductByIdUseCase(productRepository)
    
    /**
     * Initialize the SDK with platform-specific services
     * Should be called once during app startup
     */
    fun initialize() {
        platformServices?.logMessage("SharedSDK", "SDK initialized on ${platformServices.getPlatformName()}")
    }
    
    // User operations
    
    /**
     * Gets all users
     * @return List of all users
     */
    suspend fun getUsers(): List<User> {
        return getUsersUseCase.execute()
    }
    
    /**
     * Gets a specific user by ID
     * @param userId The user ID to retrieve
     * @return The user if found, null otherwise
     */
    suspend fun getUserById(userId: String): User? {
        return getUserByIdUseCase.execute(userId)
    }
    
    /**
     * Searches users by name
     * @param query The search query
     * @return List of matching users
     */
    suspend fun searchUsers(query: String): List<User> {
        return getUsersUseCase.searchByName(query)
    }
    
    // Product operations
    
    /**
     * Gets all products
     * @return List of all products
     */
    suspend fun getProducts(): List<Product> {
        return getProductsUseCase.execute()
    }
    
    /**
     * Gets a specific product by ID
     * @param productId The product ID to retrieve
     * @return The product if found, null otherwise
     */
    suspend fun getProductById(productId: String): Product? {
        return getProductByIdUseCase.execute(productId)
    }
    
    /**
     * Searches products by title or description
     * @param query The search query
     * @return List of matching products
     */
    suspend fun searchProducts(query: String): List<Product> {
        return getProductsUseCase.searchProducts(query)
    }
    
    /**
     * Gets products within a price range
     * @param minPrice Minimum price
     * @param maxPrice Maximum price
     * @return List of products in the specified price range
     */
    suspend fun getProductsByPriceRange(minPrice: Double, maxPrice: Double): List<Product> {
        return getProductsUseCase.getProductsByPriceRange(minPrice, maxPrice)
    }
    
    // Navigation operations (requires platform navigator)
    
    /**
     * Navigates to user details
     * @param userId The user ID to show details for
     */
    fun navigateToUserDetails(userId: String) {
        platformNavigator?.navigateToUserDetails(userId)
        platformServices?.logMessage("SharedSDK", "Navigation to user details: $userId")
    }
    
    /**
     * Navigates to product details
     * @param productId The product ID to show details for
     */
    fun navigateToProductDetails(productId: String) {
        platformNavigator?.navigateToProductDetails(productId)
        platformServices?.logMessage("SharedSDK", "Navigation to product details: $productId")
    }
    
    /**
     * Navigates back
     */
    fun navigateBack() {
        platformNavigator?.navigateBack()
    }
    
    /**
     * Shows a message using platform-specific UI
     * @param message The message to display
     */
    fun showMessage(message: String) {
        platformServices?.showMessage(message)
    }
    
    /**
     * Gets platform information
     * @return Platform name and device info
     */
    fun getPlatformInfo(): String {
        return platformServices?.let { services ->
            "${services.getPlatformName()} - ${services.getDeviceInfo()}"
        } ?: "Unknown Platform"
    }
}