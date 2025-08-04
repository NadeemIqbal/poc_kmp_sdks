package main_code.repository

import main_code.data.Product
import kotlinx.coroutines.delay

/**
 * Fake implementation of ProductRepository for demonstration and testing purposes
 * Contains hardcoded sample data and simulates network delays
 */
class FakeProductRepository : ProductRepository {
    
    private val products = listOf(
        Product(
            id = "1",
            title = "Wireless Headphones",
            description = "High-quality bluetooth wireless headphones with noise cancellation",
            price = 199.99
        ),
        Product(
            id = "2",
            title = "Smartphone",
            description = "Latest flagship smartphone with advanced camera and 5G connectivity",
            price = 799.99
        ),
        Product(
            id = "3",
            title = "Laptop",
            description = "Powerful laptop for gaming and professional work",
            price = 1299.99
        ),
        Product(
            id = "4",
            title = "Smart Watch",
            description = "Fitness tracking smartwatch with heart rate monitor",
            price = 299.99
        ),
        Product(
            id = "5",
            title = "Tablet",
            description = "10-inch tablet perfect for reading and media consumption",
            price = 399.99
        ),
        Product(
            id = "6",
            title = "Bluetooth Speaker",
            description = "Portable bluetooth speaker with excellent sound quality",
            price = 79.99
        )
    )
    
    override suspend fun getProducts(): List<Product> {
        // Simulate network delay
        delay(600)
        return products
    }
    
    override suspend fun getProductById(id: String): Product? {
        // Simulate network delay
        delay(300)
        return products.find { it.id == id }
    }
    
    override suspend fun searchProducts(query: String): List<Product> {
        // Simulate network delay
        delay(400)
        return products.filter { product ->
            product.title.contains(query, ignoreCase = true) ||
            product.description.contains(query, ignoreCase = true)
        }
    }
    
    override suspend fun getProductsByPriceRange(minPrice: Double, maxPrice: Double): List<Product> {
        // Simulate network delay
        delay(500)
        return products.filter { product ->
            product.price >= minPrice && product.price <= maxPrice
        }
    }
}