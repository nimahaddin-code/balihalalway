import SwiftUI

/// Full-screen Detail Route view showing a scrollable list of halal restaurant cards.
/// Each card displays a thumbnail, restaurant name, description, halal certification, and distance.
struct DetailRouteView: View {
    let restaurants: [Restaurant]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Location header
            Text("Kuta, Bali")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 4)

            Divider()
                .padding(.horizontal, 20)

            // Restaurant card list
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(restaurants) { restaurant in
                        RestaurantCardView(restaurant: restaurant)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
        }
    }
}

// MARK: - Restaurant Card View
struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Thumbnail placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(cardColor(for: restaurant.imagePlaceholderColor).opacity(0.20))
                if UIImage(named: restaurant.imageName) != nil {
                    Image(restaurant.imageName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: thumbnailIcon(for: restaurant.name))
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(cardColor(for: restaurant.imagePlaceholderColor))
                        .padding(20)
                }
            }
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            // Restaurant details
            VStack(alignment: .leading, spacing: 6) {
                Text(restaurant.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(restaurant.description)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(4)

                Text("Halal Certified")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.primary)

                // Distance badge
                Text(restaurant.distance)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(red: 0.30, green: 0.35, blue: 0.60))
                    )
            }
            .padding(.vertical, 4)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
        )
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
    DetailRouteView(restaurants: Restaurant.sampleData)
}
