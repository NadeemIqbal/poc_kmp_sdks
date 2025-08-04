package main_code.domain

import main_code.data.User
import main_code.repository.UserRepository

/**
 * Use case for retrieving users
 * Encapsulates the business logic for user retrieval operations
 */
class GetUsersUseCase(
    private val userRepository: UserRepository
) {
    
    /**
     * Executes the use case to get all users
     * @return List of all users
     */
    suspend fun execute(): List<User> {
        return userRepository.getUsers()
    }
    
    /**
     * Executes the use case to search users by name
     * @param query Search query for user names
     * @return List of users matching the search criteria
     */
    suspend fun searchByName(query: String): List<User> {
        return if (query.isBlank()) {
            userRepository.getUsers()
        } else {
            userRepository.searchUsersByName(query)
        }
    }
}