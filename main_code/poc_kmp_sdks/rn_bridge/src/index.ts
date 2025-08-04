import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'kmp-shared-sdk-rn' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const KmpSharedSdkRn = NativeModules.KmpSharedSdkRn
  ? NativeModules.KmpSharedSdkRn
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export interface User {
  id: string;
  name: string;
  email: string;
}

export interface Product {
  id: string;
  title: string;
  description: string;
  price: number;
}

export class KmpSharedSdk {
  /**
   * Initialize the SDK
   * Should be called once during app startup
   */
  async initialize(): Promise<void> {
    return KmpSharedSdkRn.initialize();
  }

  // User operations

  /**
   * Gets all users
   */
  async getUsers(): Promise<User[]> {
    return KmpSharedSdkRn.getUsers();
  }

  /**
   * Gets a specific user by ID
   * Returns null if user is not found
   */
  async getUserById(userId: string): Promise<User | null> {
    return KmpSharedSdkRn.getUserById(userId);
  }

  /**
   * Searches users by name
   * Returns empty array if no matches found
   */
  async searchUsers(query: string): Promise<User[]> {
    return KmpSharedSdkRn.searchUsers(query);
  }

  // Product operations

  /**
   * Gets all products
   */
  async getProducts(): Promise<Product[]> {
    return KmpSharedSdkRn.getProducts();
  }

  /**
   * Gets a specific product by ID
   * Returns null if product is not found
   */
  async getProductById(productId: string): Promise<Product | null> {
    return KmpSharedSdkRn.getProductById(productId);
  }

  /**
   * Searches products by title or description
   * Returns empty array if no matches found
   */
  async searchProducts(query: string): Promise<Product[]> {
    return KmpSharedSdkRn.searchProducts(query);
  }

  /**
   * Gets products within a price range
   * Returns empty array if no products found in range
   */
  async getProductsByPriceRange(minPrice: number, maxPrice: number): Promise<Product[]> {
    return KmpSharedSdkRn.getProductsByPriceRange(minPrice, maxPrice);
  }

  // Navigation operations

  /**
   * Navigates to user details screen
   */
  async navigateToUserDetails(userId: string): Promise<void> {
    return KmpSharedSdkRn.navigateToUserDetails(userId);
  }

  /**
   * Navigates to product details screen
   */
  async navigateToProductDetails(productId: string): Promise<void> {
    return KmpSharedSdkRn.navigateToProductDetails(productId);
  }

  /**
   * Navigates back to the previous screen
   */
  async navigateBack(): Promise<void> {
    return KmpSharedSdkRn.navigateBack();
  }

  /**
   * Shows a platform-specific message
   */
  async showMessage(message: string): Promise<void> {
    return KmpSharedSdkRn.showMessage(message);
  }

  /**
   * Gets platform information
   */
  async getPlatformInfo(): Promise<string> {
    return KmpSharedSdkRn.getPlatformInfo();
  }
}

// Export default instance for convenience
export default new KmpSharedSdk();

// Also export the class for custom instances
export { KmpSharedSdk };