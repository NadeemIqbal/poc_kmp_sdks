import Foundation
import UIKit
import SharedSDK

/// iOS implementation of PlatformServices
/// Provides iOS-specific functionality
class IOSPlatformServices: PlatformServices {
    
    func getPlatformName() -> String {
        return "iOS \(UIDevice.current.systemVersion)"
    }
    
    func showMessage(message: String) {
        DispatchQueue.main.async {
            // In a real app, you might want to show a toast or alert
            // For now, we'll use a simple alert
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                window.rootViewController?.present(alert, animated: true)
            }
        }
    }
    
    func logMessage(tag: String, message: String) {
        print("[\(tag)] \(message)")
    }
    
    func getDeviceInfo() -> String {
        let device = UIDevice.current
        return "\(device.model) (\(device.systemName) \(device.systemVersion))"
    }
}