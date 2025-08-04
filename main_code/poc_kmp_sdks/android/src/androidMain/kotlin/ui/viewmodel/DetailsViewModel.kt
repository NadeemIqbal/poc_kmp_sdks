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
 * ViewModel for the Details screen
 * Manages UI state and business logic for displaying individual item details
 */
class DetailsViewModel(
    private val sharedSDK: SharedSDK = SharedSDK()
) : ViewModel() {
    
    private val _uiState = MutableStateFlow(DetailsUiState())
    val uiState: StateFlow<DetailsUiState> = _uiState.asStateFlow()
    
    /**
     * Loads an item (user or product) by ID and type
     */
    fun loadItem(itemId: String, itemType: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoading = true, error = null)
            
            try {
                when (itemType.lowercase()) {
                    "user" -> {
                        val user = sharedSDK.getUserById(itemId)
                        if (user != null) {
                            _uiState.value = _uiState.value.copy(
                                isLoading = false,
                                user = user,
                                product = null
                            )
                        } else {
                            _uiState.value = _uiState.value.copy(
                                isLoading = false,
                                error = "User not found"
                            )
                        }
                    }
                    
                    "product" -> {
                        val product = sharedSDK.getProductById(itemId)
                        if (product != null) {
                            _uiState.value = _uiState.value.copy(
                                isLoading = false,
                                product = product,
                                user = null
                            )
                        } else {
                            _uiState.value = _uiState.value.copy(
                                isLoading = false,
                                error = "Product not found"
                            )
                        }
                    }
                    
                    else -> {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = "Invalid item type: $itemType"
                        )
                    }
                }
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    error = e.message ?: "Unknown error occurred"
                )
            }
        }
    }
    
    /**
     * Navigates back using the shared SDK
     */
    fun navigateBack() {
        sharedSDK.navigateBack()
    }
}

/**
 * UI state for the Details screen
 */
data class DetailsUiState(
    val isLoading: Boolean = false,
    val user: User? = null,
    val product: Product? = null,
    val error: String? = null
)