package main_code.repository

import main_code.data.Product

interface ProductRepository {
    suspend fun getProducts(): List<Product>
    suspend fun getProductById(id: String): Product?
    suspend fun searchProducts(query: String): List<Product>
    suspend fun getProductsByPriceRange(minPrice: Double, maxPrice: Double): List<Product>
}