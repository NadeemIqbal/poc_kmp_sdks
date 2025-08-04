package org.nadeem.project

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.compose.rememberNavController
import ui.HomeScreen
import ui.navigation.AppNavigation

@Composable
@Preview
fun App() {
    MaterialTheme {
        // Use the proper SDK demo with navigation
        val navController = rememberNavController()
        AppNavigation(
            navController = navController,
            appTitle = "KMP Sample App"
        )
    }
}