package main_code.platform

import android.content.Context
import android.os.Build
import android.util.Log
import android.widget.Toast

/**
 * Android implementation of PlatformServices
 * Provides Android-specific functionality
 */
class AndroidPlatformServices(
    private val context: Context
) : PlatformServices {
    
    override fun getPlatformName(): String {
        return "Android ${Build.VERSION.RELEASE}"
    }
    
    override fun showMessage(message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }
    
    override fun logMessage(tag: String, message: String) {
        Log.d(tag, message)
    }
    
    override fun getDeviceInfo(): String {
        return "${Build.MANUFACTURER} ${Build.MODEL} (API ${Build.VERSION.SDK_INT})"
    }
}