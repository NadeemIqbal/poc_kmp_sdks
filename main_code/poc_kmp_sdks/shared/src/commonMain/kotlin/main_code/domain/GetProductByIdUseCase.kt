package main_code.domain

import main_code.data.Product
import main_code.repository.ProductRepository

/**
 * Use case for retrieving a specific product by ID
 * Encapsulates the business logic for single product retrieval
 */
class GetProductByIdUseCase(
    private val productRepository: ProductRepository
) {
    
    /**
     * Executes the use case to get a product by ID
     * @param productId The unique identifier of the product
     * @return The product if found, null otherwise
     * @throws IllegalArgumentException if productId is blank
     */
    suspend fun execute(productId: String): Product? {
        require(productId.isNotBlank()) { 
            "Product ID cannot be blank" 
        }
        
        return productRepository.getProductById(productId)
    }
}