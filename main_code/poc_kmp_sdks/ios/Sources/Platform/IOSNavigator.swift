import Foundation
import UIKit
import SwiftUI
import SharedSDK

/// iOS implementation of PlatformNavigator
/// Provides iOS-specific navigation logic
class IOSNavigator: PlatformNavigator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func navigateToUserDetails(userId: String) {
        guard let navigationController = navigationController else {
            print("Navigation controller not set")
            return
        }
        
        let detailsView = DetailsView(itemId: userId, itemType: .user)
        let hostingController = UIHostingController(rootView: detailsView)
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func navigateToProductDetails(productId: String) {
        guard let navigationController = navigationController else {
            print("Navigation controller not set")
            return
        }
        
        let detailsView = DetailsView(itemId: productId, itemType: .product)
        let hostingController = UIHostingController(rootView: detailsView)
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func navigateBack() {
        guard let navigationController = navigationController else {
            print("Navigation controller not set")
            return
        }
        
        navigationController.popViewController(animated: true)
    }
    
    func navigateToHome() {
        guard let navigationController = navigationController else {
            print("Navigation controller not set")
            return
        }
        
        navigationController.popToRootViewController(animated: true)
    }
}