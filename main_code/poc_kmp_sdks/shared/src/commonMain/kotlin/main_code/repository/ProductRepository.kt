package main_code.repository

import main_code.data.Product

/**
 * Interface for product data operations
 * Provides methods for retrieving product information
 */
interface ProductRepository {
    
    /**
     * Retrieves all products from the data source
     * @return List of all products
     */
    suspend fun getProducts(): List<Product>
    
    /**
     * Retrieves a specific product by its ID
     * @param id The unique identifier of the product
     * @return The product if found, null otherwise
     */
    suspend fun getProductById(id: String): Product?
    
    /**
     * Searches products by title or description
     * @param query The search query to match against product title and description
     * @return List of products matching the search criteria
     */
    suspend fun searchProducts(query: String): List<Product>
    
    /**
     * Filters products by price range
     * @param minPrice Minimum price filter
     * @param maxPrice Maximum price filter
     * @return List of products within the specified price range
     */
    suspend fun getProductsByPriceRange(minPrice: Double, maxPrice: Double): List<Product>
}