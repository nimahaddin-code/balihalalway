import SwiftUI

/// A floating card shown on the map for each halal restaurant.
/// Displays a thumbnail placeholder, restaurant name, and distance.
struct RestaurantAnnotationView: View {
    let restaurant: Restaurant

    var body: some View {
        VStack(spacing: 0) {
            // Floating card
            HStack(spacing: 8) {
                // Thumbnail placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(colorFromString(restaurant.imagePlaceholderColor).opacity(0.25))
                    Image(systemName: thumbnailIcon(for: restaurant.name))
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(colorFromString(restaurant.imagePlaceholderColor))
                        .padding(6)
                }
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 2) {
                    Text(restaurant.name)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(restaurant.distance)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 2)
            )
            .fixedSize()

            // Pin stem
            Rectangle()
                .fill(Color(red: 0.95, green: 0.40, blue: 0.10))
                .frame(width: 3, height: 14)

            // Pin head (circle)
            Circle()
                .fill(Color(red: 0.95, green: 0.40, blue: 0.10))
                .frame(width: 14, height: 14)
        }
    }

    private func colorFromString(_ name: String) -> Color {
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
        if name.contains("Taste") { return "leaf.fill" }
        return "fork.knife.circle"
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.3)
        RestaurantAnnotationView(
            restaurant: Restaurant(
                name: "Halaiku Restaurant",
                distance: "4.5 Km",
                coordinate: .init(latitude: 0, longitude: 0),
                imagePlaceholderColor: "red"
            )
        )
    }
    .frame(width: 300, height: 200)
}
