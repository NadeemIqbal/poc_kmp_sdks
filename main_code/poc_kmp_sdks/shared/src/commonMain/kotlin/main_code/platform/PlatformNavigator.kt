package main_code.platform

/**
 * Platform-specific navigation interface
 * Each platform should provide its own implementation of navigation logic
 */
interface PlatformNavigator {
    
    /**
     * Navigates to user details screen
     * @param userId The ID of the user to display
     */
    fun navigateToUserDetails(userId: String)
    
    /**
     * Navigates to product details screen
     * @param productId The ID of the product to display
     */
    fun navigateToProductDetails(productId: String)
    
    /**
     * Navigates back to the previous screen
     */
    fun navigateBack()
    
    /**
     * Navigates to the home screen
     */
    fun navigateToHome()
}