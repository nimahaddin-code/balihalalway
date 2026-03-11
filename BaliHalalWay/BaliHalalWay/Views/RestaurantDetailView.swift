import SwiftUI

/// A full detail view for a single halal restaurant, presented when tapping a map pin.
struct RestaurantDetailView: View {
    let restaurant: Restaurant

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Hero image
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardColor(for: restaurant.imagePlaceholderColor).opacity(0.20))
                    if UIImage(named: restaurant.imageName) != nil {
                        Image(restaurant.imageName)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    } else {
                        Image(systemName: thumbnailIcon(for: restaurant.name))
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(cardColor(for: restaurant.imagePlaceholderColor))
                            .padding(40)
                    }
                }
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                // Restaurant name
                Text(restaurant.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)

                // Halal badge + distance
                HStack(spacing: 10) {
                    Label("Halal Certified", systemImage: "checkmark.seal.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.green)

                    Text(restaurant.distance)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(red: 0.30, green: 0.35, blue: 0.60))
                        )
                }

                Divider()

                // Description
                Text("Description")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Text(restaurant.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Divider()

                // Location
                Text("Location")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color(red: 0.95, green: 0.40, blue: 0.10))
                    Text(String(
                        format: "%.4f, %.4f",
                        restaurant.coordinate.latitude,
                        restaurant.coordinate.longitude
                    ))
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.secondary)
                }
            }
            .padding(20)
        }
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func cardColor(for name: String) -> Color {
        switch name {
        case "red":    return Color.red
        case "orange": return Color.orange
        case "green":  return Color.green
        case "brown":  return Color(red: 0.55, green: 0.35, blue: 0.10)
        default:       return Color.orange
        }
    }

    private func thumbnailIcon(for name: String) -> String {
        if name.contains("Restaurant") { return "fork.knife" }
        if name.contains("Warung") { return "takeoutbag.and.cup.and.straw" }
        if name.contains("Kitchen") { return "leaf.fill" }
        if name.contains("Food") { return "fork.knife.circle" }
        return "fork.knife.circle"
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailView(restaurant: Restaurant.sampleData[0])
    }
}
