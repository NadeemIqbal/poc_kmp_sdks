package main_code

import main_code.data.Product
import main_code.data.User
import main_code.platform.PlatformServices
import main_code.repository.FakeProductRepository
import main_code.repository.FakeUserRepository
import main_code.repository.ProductRepository
import main_code.repository.UserRepository

class SharedSDK(
    private val platformServices: PlatformServices? = null
) {
    private val userRepository: UserRepository = FakeUserRepository()
    private val productRepository: ProductRepository = FakeProductRepository()

    fun initialize() {
        platformServices?.logMessage("SharedSDK", "SDK initialized on ${platformServices.getPlatformName()}")
    }

    suspend fun getUsers(): List<User> {
        return userRepository.getUsers()
    }

    suspend fun getUserById(userId: String): User? {
        return userRepository.getUserById(userId)
    }

    suspend fun searchUsers(query: String): List<User> {
        return userRepository.searchByName(query)
    }

    suspend fun getProducts(): List<Product> {
        return productRepository.getProducts()
    }

    suspend fun getProductById(productId: String): Product? {
        return productRepository.getProductById(productId)
    }

    suspend fun searchProducts(query: String): List<Product> {
        return productRepository.searchProducts(query)
    }

    suspend fun getProductsByPriceRange(minPrice: Double, maxPrice: Double): List<Product> {
        return productRepository.getProductsByPriceRange(minPrice, maxPrice)
    }

    fun showMessage(message: String) {
        platformServices?.showMessage(message)
    }

    fun getPlatformInfo(): String {
        return platformServices?.let { services ->
            "${services.getPlatformName()} - ${services.getDeviceInfo()}"
        } ?: "Unknown Platform"
    }
}