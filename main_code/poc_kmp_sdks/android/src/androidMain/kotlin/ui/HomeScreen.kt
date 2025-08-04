package ui

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import ui.viewmodel.HomeViewModel

/**
 * Home screen displaying users and products
 * Demonstrates the usage of shared SDK in Android Compose UI
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeScreen(
    appTitle: String = "KMP SDK Demo",
    onUserClick: (String) -> Unit = {},
    onProductClick: (String) -> Unit = {},
    viewModel: HomeViewModel = viewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    
    LaunchedEffect(Unit) {
        viewModel.loadData()
    }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        TopAppBar(
            title = { 
                Text(
                    text = appTitle,
                    style = MaterialTheme.typography.headlineSmall
                ) 
            }
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        if (uiState.isLoading) {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                CircularProgressIndicator()
            }
        } else {
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier.weight(1f)
            ) {
                // Users Section
                item {
                    SectionHeader(title = "Users (${uiState.users.size})")
                }
                
                items(uiState.users) { user ->
                    UserItem(
                        user = user,
                        onClick = { onUserClick(user.id) }
                    )
                }
                
                // Products Section
                item {
                    Spacer(modifier = Modifier.height(16.dp))
                    SectionHeader(title = "Products (${uiState.products.size})")
                }
                
                items(uiState.products) { product ->
                    ProductItem(
                        product = product,
                        onClick = { onProductClick(product.id) }
                    )
                }
            }
            
            // Launch User Details Button
            Spacer(modifier = Modifier.height(16.dp))
        }
    }
    
    // Handle error state
    uiState.error?.let { error ->
        LaunchedEffect(error) {
            // TODO: Show error message using SDK's showMessage
            // This demonstrates platform-specific error handling
        }
    }
}

@Composable
private fun SectionHeader(title: String) {
    Text(
        text = title,
        style = MaterialTheme.typography.titleMedium,
        fontWeight = FontWeight.Bold,
        modifier = Modifier.padding(vertical = 8.dp)
    )
}