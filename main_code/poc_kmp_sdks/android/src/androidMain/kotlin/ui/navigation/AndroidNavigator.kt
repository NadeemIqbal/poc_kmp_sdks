package ui.navigation

import androidx.navigation.NavController
import main_code.platform.PlatformNavigator

/**
 * Android implementation of PlatformNavigator using Jetpack Navigation
 * Provides Android-specific navigation logic
 */
class AndroidNavigator(
    private val navController: NavController
) : PlatformNavigator {
    
    override fun navigateToUserDetails(userId: String) {
        navController.navigate("details/user/$userId")
    }
    
    override fun navigateToProductDetails(productId: String) {
        navController.navigate("details/product/$productId")
    }
    
    override fun navigateBack() {
        navController.popBackStack()
    }
    
    override fun navigateToHome() {
        navController.navigate("home") {
            popUpTo("home") { inclusive = true }
        }
    }
}