package org.nadeem.project.consumer.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import main_code.SharedSDK
import main_code.platform.AndroidPlatformServices
import ui.DetailsScreen
import ui.HomeScreen
import ui.navigation.AndroidNavigator

/**
 * Main activity for the Android consumer app
 * Demonstrates SDK integration and usage
 */
class MainActivity : ComponentActivity() {
    private lateinit var sharedSDK: SharedSDK

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize the shared SDK with platform services
        val platformServices = AndroidPlatformServices(this)
        sharedSDK = SharedSDK(platformServices)
        sharedSDK.initialize()

        setContent {
            MaterialTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()
                    val androidNavigator = AndroidNavigator(navController)

                    // Always set up the navigation graph
                    NavHost(
                        navController = navController,
                        startDestination = "launcher"
                    ) {
                        // Launcher screen with buttons
                        composable("launcher") {
                            Column(
                                modifier = Modifier
                                    .fillMaxSize()
                                    .padding(16.dp),
                                horizontalAlignment = Alignment.CenterHorizontally,
                                verticalArrangement = Arrangement.Center
                            ) {
                                Text(
                                    text = "KMP Consumer App",
                                    style = MaterialTheme.typography.headlineMedium,
                                    modifier = Modifier.padding(bottom = 32.dp)
                                )
                                
                                Row(
                                    horizontalArrangement = Arrangement.spacedBy(16.dp)
                                ) {
                                    Button(
                                        onClick = {
                                            androidNavigator.navigateToUserDetails("4")
                                        }
                                    ) {
                                        Text("Launch User Details From SDK")
                                    }

                                    Button(
                                        onClick = {
                                            navController.navigate("home") {
                                                popUpTo("launcher") { inclusive = true }
                                            }
                                        }
                                    ) {
                                        Text("Launch SDK")
                                    }
                                }
                            }
                        }
                        
                        // Home screen (SDK UI)
                        composable("home") {
                            HomeScreen(
                                appTitle = "KMP Consumer App",
                                onUserClick = { userId ->
                                    navController.navigate("details/user/$userId")
                                },
                                onProductClick = { productId ->
                                    navController.navigate("details/product/$productId")
                                }
                            )
                        }
                        
                        // Details screen
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
            }
        }
    }
}