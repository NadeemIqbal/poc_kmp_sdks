package main_code.repository

import main_code.data.User
import kotlinx.coroutines.delay

/**
 * Fake implementation of UserRepository for demonstration and testing purposes
 * Contains hardcoded sample data and simulates network delays
 */
class FakeUserRepository : UserRepository {
    
    private val users = listOf(
        User(id = "1", name = "John Doe", email = "john.doe@example.com"),
        User(id = "2", name = "Jane Smith", email = "jane.smith@example.com"),
        User(id = "3", name = "Bob Johnson", email = "bob.johnson@example.com"),
        User(id = "4", name = "Alice Brown", email = "alice.brown@example.com"),
        User(id = "5", name = "Charlie Wilson", email = "charlie.wilson@example.com")
    )
    
    override suspend fun getUsers(): List<User> {
        // Simulate network delay
        delay(500)
        return users
    }
    
    override suspend fun getUserById(id: String): User? {
        // Simulate network delay
        delay(300)
        return users.find { it.id == id }
    }
    
    override suspend fun searchUsersByName(query: String): List<User> {
        // Simulate network delay
        delay(400)
        return users.filter { 
            it.name.contains(query, ignoreCase = true) 
        }
    }
}