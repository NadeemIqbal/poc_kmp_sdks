package main_code.domain

import main_code.data.User
import main_code.repository.UserRepository

/**
 * Use case for retrieving a specific user by ID
 * Encapsulates the business logic for single user retrieval
 */
class GetUserByIdUseCase(
    private val userRepository: UserRepository
) {
    
    /**
     * Executes the use case to get a user by ID
     * @param userId The unique identifier of the user
     * @return The user if found, null otherwise
     * @throws IllegalArgumentException if userId is blank
     */
    suspend fun execute(userId: String): User? {
        require(userId.isNotBlank()) { 
            "User ID cannot be blank" 
        }
        
        return userRepository.getUserById(userId)
    }
}