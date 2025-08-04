package main_code.data

import kotlinx.serialization.Serializable

/**
 * Data class representing a product in the system
 * 
 * @property id Unique identifier for the product
 * @property title Product name/title
 * @property description Detailed description of the product
 * @property price Product price in USD
 */
@Serializable
data class Product(
    val id: String,
    val title: String,
    val description: String,
    val price: Double
)