package ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import ui.DetailsScreen
import ui.HomeScreen

/**
 * Main navigation component for the Android app
 * Defines the navigation graph and routes
 */
@Composable
fun AppNavigation(
    navController: NavHostController,
    appTitle: String = "KMP SDK Demo"
) {
    NavHost(
        navController = navController,
        startDestination = "home"
    ) {
        composable("home") {
            HomeScreen(
                appTitle = appTitle,
                onUserClick = { userId ->
                    navController.navigate("details/user/$userId")
                },
                onProductClick = { productId ->
                    navController.navigate("details/product/$productId")
                }
            )
        }
        
        composable("details/{itemType}/{itemId}") { backStackEntry ->
            val itemType = backStackEntry.arguments?.getString("itemType") ?: ""
            val itemId = backStackEntry.arguments?.getString("itemId") ?: ""
            
            DetailsScreen(
                itemId = itemId,
                itemType = itemType,
                onBackClick = {
                    navController.popBackStack()
                }
            )
        }
    }
}