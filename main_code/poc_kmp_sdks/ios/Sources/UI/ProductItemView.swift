import SwiftUI
import SharedSDK

/// SwiftUI view for displaying a single product item
struct ProductItemView: View {
    let product: Product
    
    var body: some View {
        HStack {
            // Product icon
            Image(systemName: "cart.fill")
                .font(.system(size: 40))
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("ID: \(product.id)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    ProductItemView(
        product: Product(
            id: "1",
            title: "Wireless Headphones",
            description: "High-quality bluetooth wireless headphones with noise cancellation",
            price: 199.99
        )
    )
    .padding()
}