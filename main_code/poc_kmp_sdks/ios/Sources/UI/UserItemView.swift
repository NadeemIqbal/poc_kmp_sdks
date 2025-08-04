import SwiftUI
import SharedSDK

/// SwiftUI view for displaying a single user item
struct UserItemView: View {
    let user: User
    
    var body: some View {
        HStack {
            // User icon
            Image(systemName: "person.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("ID: \(user.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
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
    UserItemView(
        user: User(
            id: "1",
            name: "John Doe",
            email: "john.doe@example.com"
        )
    )
    .padding()
}