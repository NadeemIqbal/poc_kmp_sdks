package main_code.platform

/**
 * Platform-specific services interface
 * Provides access to platform-specific functionality
 */
interface PlatformServices {
    
    /**
     * Gets the platform name (Android, iOS, etc.)
     * @return Platform identifier string
     */
    fun getPlatformName(): String
    
    /**
     * Shows a platform-specific toast/alert message
     * @param message The message to display
     */
    fun showMessage(message: String)
    
    /**
     * Logs a message using platform-specific logging
     * @param tag Log tag/category
     * @param message Log message
     */
    fun logMessage(tag: String, message: String)
    
    /**
     * Gets device information
     * @return Device info as a string
     */
    fun getDeviceInfo(): String
}