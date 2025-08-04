package ui.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import main_code.SharedSDK
import main_code.data.Product
import main_code.data.User

/**
 * ViewModel for the Home screen
 * Manages UI state and business logic for displaying users and products
 */
class HomeViewModel(
    private val sharedSDK: SharedSDK = SharedSDK()
) : ViewModel() {
    
    private val _uiState = MutableStateFlow(HomeUiState())
    val uiState: StateFlow<HomeUiState> = _uiState.asStateFlow()
    
    /**
     * Loads users and products from the shared SDK
     */
    fun loadData() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoading = true, error = null)
            
            try {
                // Load users and products concurrently
                val users = sharedSDK.getUsers()
                val products = sharedSDK.getProducts()
                
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    users = users,
                    products = products
                )
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    error = e.message ?: "Unknown error occurred"
                )
            }
        }
    }
    
    /**
     * Searches users by name
     */
    fun searchUsers(query: String) {
        viewModelScope.launch {
            try {
                val users = sharedSDK.searchUsers(query)
                _uiState.value = _uiState.value.copy(users = users)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    error = e.message ?: "Search failed"
                )
            }
        }
    }
    
    /**
     * Searches products by title/description
     */
    fun searchProducts(query: String) {
        viewModelScope.launch {
            try {
                val products = sharedSDK.searchProducts(query)
                _uiState.value = _uiState.value.copy(products = products)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    error = e.message ?: "Search failed"
                )
            }
        }
    }
    
    /**
     * Navigates to user details using the shared SDK
     */
    fun navigateToUserDetails(userId: String) {
        sharedSDK.navigateToUserDetails(userId)
    }
    
    /**
     * Navigates to product details using the shared SDK
     */
    fun navigateToProductDetails(productId: String) {
        sharedSDK.navigateToProductDetails(productId)
    }
}

/**
 * UI state for the Home screen
 */
data class HomeUiState(
    val isLoading: Boolean = false,
    val users: List<User> = emptyList(),
    val products: List<Product> = emptyList(),
    val error: String? = null
)