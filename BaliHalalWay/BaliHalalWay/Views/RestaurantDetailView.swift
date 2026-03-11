import SwiftUI
import MapKit

struct RestaurantDetailView: View {
    let restaurant: Restaurant

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(colorFromString(restaurant.imagePlaceholderColor).opacity(0.20))
                    if UIImage(named: restaurant.imageName) != nil {
                        Image(restaurant.imageName)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: thumbnailIcon(for: restaurant.name))
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(colorFromString(restaurant.imagePlaceholderColor))
                            .padding(40)
                    }
                }
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)

                Text(restaurant.name)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 16)

                HStack(spacing: 6) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                    Text("Halal Certified")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.green)
                }
                .padding(.horizontal, 16)

                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color(red: 0.30, green: 0.35, blue: 0.60))
                    Text(restaurant.distance)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)

                Text(restaurant.description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)

                Map(position: .constant(.region(
                    MKCoordinateRegion(
                        center: restaurant.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    )
                ))) {
                    Marker(restaurant.name, coordinate: restaurant.coordinate)
                        .tint(.orange)
                }
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)

                Button {
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: restaurant.coordinate))
                    mapItem.name = restaurant.name
                    mapItem.openInMaps()
                } label: {
                    HStack {
                        Image(systemName: "map.fill")
                        Text("Open in Apple Maps")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 0.30, green: 0.35, blue: 0.60))
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            .padding(.top, 16)
        }
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
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
