import CoreLocation

struct Restaurant: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let distance: String
    let coordinate: CLLocationCoordinate2D
    let imagePlaceholderColor: String

    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        lhs.id == rhs.id
    }
}

extension Restaurant {
    static let sampleData: [Restaurant] = [
        Restaurant(
            name: "Halaiku Restaurant",
            distance: "4.5 Km",
            coordinate: CLLocationCoordinate2D(latitude: -8.6560, longitude: 115.2130),
            imagePlaceholderColor: "red"
        ),
        Restaurant(
            name: "Warung Halal Bali",
            distance: "3.6 Km",
            coordinate: CLLocationCoordinate2D(latitude: -8.6650, longitude: 115.2350),
            imagePlaceholderColor: "orange"
        ),
        Restaurant(
            name: "Ubud Halal Taste",
            distance: "2.0 Km",
            coordinate: CLLocationCoordinate2D(latitude: -8.7020, longitude: 115.2120),
            imagePlaceholderColor: "green"
        ),
        Restaurant(
            name: "Kuta Halal Bites",
            distance: "4.6 Km",
            coordinate: CLLocationCoordinate2D(latitude: -8.7250, longitude: 115.2090),
            imagePlaceholderColor: "brown"
        )
    ]
}
