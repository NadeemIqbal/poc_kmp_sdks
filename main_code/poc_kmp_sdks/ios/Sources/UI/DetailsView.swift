import SwiftUI
import SharedSDK

/// Details view that can display either user or product details
/// Demonstrates shared SDK usage for fetching individual items
struct DetailsView: View {
    let itemId: String
    let itemType: ItemType
    
    @StateObject private var viewModel = DetailsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    enum ItemType {
        case user
        case product
        
        var title: String {
            switch self {
            case .user:
                return "User Details"
            case .product:
                return "Product Details"
            }
        }
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.error {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    
                    Text("Error")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(error)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let user = viewModel.user {
                UserDetailsView(user: user)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } else if let product = viewModel.product {
                ProductDetailsView(product: product)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } else {
                VStack {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    Text("No data found")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle(itemType.title)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.loadItem(itemId: itemId, itemType: itemType)
        }
    }
}

/// User details content view
struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 20) {
            // User avatar
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            VStack(spacing: 8) {
                Text(user.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("User ID:")
                    .fontWeight(.semibold)
                Spacer()
                Text(user.id)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
    }
}

/// Product details content view
struct ProductDetailsView: View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "cart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Description")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 20)
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("Product ID:")
                    .fontWeight(.semibold)
                Spacer()
                Text(product.id)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
    }
}

#Preview("User Details") {
    NavigationView {
        DetailsView(
            itemId: "1",
            itemType: .user
        )
    }
}

#Preview("Product Details") {
    NavigationView {
        DetailsView(
            itemId: "1",
            itemType: .product
        )
    }
}