package main_code.data

import kotlinx.serialization.Serializable

/**
 * Data class representing a user in the system
 * 
 * @property id Unique identifier for the user
 * @property name Full name of the user
 * @property email Email address of the user
 */
@Serializable
data class User(
    val id: String,
    val name: String,
    val email: String
)