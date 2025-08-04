import SwiftUI
import SharedSDK

/// Main home view displaying users and products
/// Demonstrates the usage of shared SDK in iOS SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let appTitle: String
    
    init(appTitle: String = "KMP SDK Demo") {
        self.appTitle = appTitle
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            // Users Section
                            SectionHeaderView(title: "Users (\(viewModel.users.count))")
                            
                            ForEach(viewModel.users, id: \.id) { user in
                                NavigationLink(destination: DetailsView(itemId: user.id, itemType: .user)) {
                                    UserItemView(user: user)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            // Products Section
                            SectionHeaderView(title: "Products (\(viewModel.products.count))")
                            
                            ForEach(viewModel.products, id: \.id) { product in
                                NavigationLink(destination: DetailsView(itemId: product.id, itemType: .product)) {
                                    ProductItemView(product: product)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(appTitle)
            .onAppear {
                viewModel.loadData()
            }
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") {
                    viewModel.clearError()
                }
            } message: {
                Text(viewModel.error ?? "")
            }
        }
    }
}

/// Section header view for grouping content
struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeView()
}