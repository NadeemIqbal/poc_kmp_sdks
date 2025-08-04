package main_code.domain

import main_code.data.Product
import main_code.repository.ProductRepository

/**
 * Use case for retrieving products
 * Encapsulates the business logic for product retrieval operations
 */
class GetProductsUseCase(
    private val productRepository: ProductRepository
) {
    
    /**
     * Executes the use case to get all products
     * @return List of all products
     */
    suspend fun execute(): List<Product> {
        return productRepository.getProducts()
    }
    
    /**
     * Executes the use case to search products
     * @param query Search query for product title and description
     * @return List of products matching the search criteria
     */
    suspend fun searchProducts(query: String): List<Product> {
        return if (query.isBlank()) {
            productRepository.getProducts()
        } else {
            productRepository.searchProducts(query)
        }
    }
    
    /**
     * Executes the use case to filter products by price range
     * @param minPrice Minimum price filter
     * @param maxPrice Maximum price filter
     * @return List of products within the specified price range
     * @throws IllegalArgumentException if price range is invalid
     */
    suspend fun getProductsByPriceRange(minPrice: Double, maxPrice: Double): List<Product> {
        require(minPrice >= 0) { 
            "Minimum price cannot be negative" 
        }
        require(maxPrice >= minPrice) { 
            "Maximum price must be greater than or equal to minimum price" 
        }
        
        return productRepository.getProductsByPriceRange(minPrice, maxPrice)
    }
}