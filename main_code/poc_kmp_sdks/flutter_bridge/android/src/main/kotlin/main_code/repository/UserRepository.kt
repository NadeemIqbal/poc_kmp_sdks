package main_code.repository

import main_code.data.User

interface UserRepository {
    suspend fun getUsers(): List<User>
    suspend fun getUserById(id: String): User?
    suspend fun searchByName(query: String): List<User>
}