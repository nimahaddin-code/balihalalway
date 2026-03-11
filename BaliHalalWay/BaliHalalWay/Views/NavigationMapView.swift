import SwiftUI
import MapKit

/// Main map view showing halal restaurants in Bali.
/// Includes a top segmented control:
///   - Navigation (index 0): full map with all annotations.
///   - Detail Route (index 1): zooms to the nearest restaurant and shows a
///     bottom route-summary panel with all restaurants listed in order.
struct NavigationMapView: View {

    @State private var selectedTab: Int = 0

    // Bali / Sanur region
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.6900, longitude: 115.2280),
            span: MKCoordinateSpan(latitudeDelta: 0.1100, longitudeDelta: 0.0900)
        )
    )

    private let restaurants = Restaurant.sampleData

    var body: some View {
        ZStack(alignment: .top) {

            // MARK: - Map
            Map(position: $cameraPosition) {

                // Restaurant annotations
                ForEach(restaurants) { restaurant in
                    Annotation(
                        restaurant.name,
                        coordinate: restaurant.coordinate,
                        anchor: .bottom
                    ) {
                        RestaurantAnnotationView(restaurant: restaurant)
                    }
                    .annotationTitles(.hidden)
                }

                // SPBU Pertamina
                Annotation(
                    "SPBU Pertamina",
                    coordinate: CLLocationCoordinate2D(latitude: -8.6480, longitude: 115.2310)
                ) {
                    POIAnnotationView(
                        label: "SPBU Pertamina",
                        icon: "fuelpump.fill",
                        bgColor: Color(red: 0.20, green: 0.60, blue: 0.90),
                        textColor: .white
                    )
                }

                // Museum Le Mayeur
                Annotation(
                    "Museum Le Mayeur",
                    coordinate: CLLocationCoordinate2D(latitude: -8.6870, longitude: 115.2610)
                ) {
                    POIAnnotationView(
                        label: "Museum Le Mayeur",
                        icon: "building.columns.fill",
                        bgColor: Color(red: 0.85, green: 0.30, blue: 0.75),
                        textColor: .white
                    )
                }

                // Icon Bali Mall
                Annotation(
                    "Icon Bali Mall",
                    coordinate: CLLocationCoordinate2D(latitude: -8.7060, longitude: 115.2590)
                ) {
                    POIAnnotationView(
                        label: "Icon Bali Mall",
                        icon: "bag.fill",
                        bgColor: Color(red: 0.95, green: 0.75, blue: 0.10),
                        textColor: .white
                    )
                }

                // Artasedana Sanur
                Annotation(
                    "Artasedana Sanur",
                    coordinate: CLLocationCoordinate2D(latitude: -8.7200, longitude: 115.2620)
                ) {
                    POIAnnotationView(
                        label: "Artasedana Sanur",
                        icon: "briefcase.fill",
                        bgColor: Color(red: 0.95, green: 0.75, blue: 0.10),
                        textColor: .white
                    )
                }

                // Prama Sanur Beach Bali
                Annotation(
                    "Prama Sanur\nBeach Bali",
                    coordinate: CLLocationCoordinate2D(latitude: -8.7500, longitude: 115.2600)
                ) {
                    POIAnnotationView(
                        label: "Prama Sanur\nBeach Bali",
                        icon: "bed.double.fill",
                        bgColor: Color(red: 0.60, green: 0.50, blue: 0.80),
                        textColor: .white
                    )
                }

                // User location arrow indicator
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: -8.6820, longitude: 115.2320)) {
                    Image(systemName: "location.north.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(red: 0.15, green: 0.25, blue: 0.65))
                        .rotationEffect(.degrees(20))
                }
            }
            .ignoresSafeArea()
            .mapStyle(.standard(elevation: .realistic))

            // MARK: - Top Navigation Bar
            topNavigationBar
                .padding(.top, 8)

            // MARK: - Detail Route bottom panel (shown when selectedTab == 1)
            if selectedTab == 1 {
                detailRoutePanel
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onChange(of: selectedTab) { _, newTab in
            withAnimation(.easeInOut(duration: 0.4)) {
                if newTab == 1 {
                    // Zoom in on the nearest restaurant when entering Detail Route
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: restaurants.first?.coordinate
                                ?? CLLocationCoordinate2D(latitude: -8.6900, longitude: 115.2280),
                            span: MKCoordinateSpan(latitudeDelta: 0.0500, longitudeDelta: 0.0400)
                        )
                    )
                } else {
                    // Restore full Bali / Sanur overview
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: -8.6900, longitude: 115.2280),
                            span: MKCoordinateSpan(latitudeDelta: 0.1100, longitudeDelta: 0.0900)
                        )
                    )
                }
            }
        }
    }

    // MARK: - Detail Route Panel
    private var detailRoutePanel: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("Route Summary")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, 4)
                ForEach(Array(restaurants.enumerated()), id: \.element.id) { index, restaurant in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.95, green: 0.40, blue: 0.10))
                                .frame(width: 28, height: 28)
                            Text("\(index + 1)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(restaurant.name)
                                .font(.system(size: 14, weight: .semibold))
                            Text(restaurant.distance)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    if index < restaurants.count - 1 {
                        Divider().padding(.leading, 40)
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -4)
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // MARK: - Segmented Navigation Control
    private var topNavigationBar: some View {
        HStack(spacing: 0) {
            tabButton(title: "Navigation", index: 0)
            tabButton(title: "Detail Route", index: 1)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(UIColor.systemGray5))
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 24)
    }

    @ViewBuilder
    private func tabButton(title: String, index: Int) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = index
            }
        } label: {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(selectedTab == index ? .black : Color(UIColor.secondaryLabel))
                .padding(.vertical, 11)
                .padding(.horizontal, 28)
                .background(
                    Group {
                        if selectedTab == index {
                            RoundedRectangle(cornerRadius: 22)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 1)
                        }
                    }
                )
        }
        .buttonStyle(.plain)
        .padding(3)
    }
}

// MARK: - POI Annotation View
struct POIAnnotationView: View {
    let label: String
    let icon: String
    let bgColor: Color
    let textColor: Color

    var body: some View {
        HStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(bgColor)
                    .frame(width: 28, height: 28)
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(textColor)
            }
            Text(label)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(bgColor)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
    }
}

#Preview {
    NavigationMapView()
}
