package main_code.platform

import platform.Foundation.NSLog
import platform.UIKit.UIDevice

/**
 * iOS implementation of PlatformServices
 * Provides iOS-specific functionality
 */
class IOSPlatformServices : PlatformServices {
    
    override fun getPlatformName(): String {
        return "iOS ${UIDevice.currentDevice.systemVersion}"
    }
    
    override fun showMessage(message: String) {
        // TODO: Implement iOS-specific message display (e.g., UIAlertController)
        // For now, just log the message
        NSLog("Message: $message")
    }
    
    override fun logMessage(tag: String, message: String) {
        NSLog("[$tag] $message")
    }
    
    override fun getDeviceInfo(): String {
        val device = UIDevice.currentDevice
        return "${device.model} (${device.systemName} ${device.systemVersion})"
    }
}