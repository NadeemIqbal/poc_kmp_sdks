package main_code.repository

import main_code.data.User

/**
 * Interface for user data operations
 * Provides methods for retrieving user information
 */
interface UserRepository {
    
    /**
     * Retrieves all users from the data source
     * @return List of all users
     */
    suspend fun getUsers(): List<User>
    
    /**
     * Retrieves a specific user by their ID
     * @param id The unique identifier of the user
     * @return The user if found, null otherwise
     */
    suspend fun getUserById(id: String): User?
    
    /**
     * Searches users by name
     * @param query The search query to match against user names
     * @return List of users matching the search criteria
     */
    suspend fun searchUsersByName(query: String): List<User>
}