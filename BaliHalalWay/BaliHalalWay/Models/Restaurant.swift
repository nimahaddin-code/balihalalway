import CoreLocation

struct Restaurant: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let description: String
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
            name: "Halalku Restaurant",
            description: "Halalku Restaurant is located in Ubud, Bali. It serves Indonesian halal food and is popular among Muslim travelers.",
            distance: "3.5 km",
            coordinate: CLLocationCoordinate2D(latitude: -8.6560, longitude: 115.2130),
            imagePlaceholderColor: "red"
        ),
        Restaurant(
            name: "Warung Halal Bali",
            description: "Warung Halal Bali is located in Kuta, Bali. It offers traditional Indonesian dishes with halal food status.",
            distance: "4.8 km",
            coordinate: CLLocationCoordinate2D(latitude: -8.6650, longitude: 115.2350),
            imagePlaceholderColor: "orange"
        ),
        Restaurant(
            name: "Canggu Halal Kitchen",
            description: "Canggu Halal Kitchen is located in Canggu, Bali. It serves halal Middle Eastern and Indonesian food.",
            distance: "4.9 km",
            coordinate: CLLocationCoordinate2D(latitude: -8.7020, longitude: 115.2120),
            imagePlaceholderColor: "green"
        ),
        Restaurant(
            name: "Denpasar Halal Food",
            description: "Denpasar Halal Food Corner is located in Denpasar, Bali. It provides halal local street food for Muslim visitors.",
            distance: "5.6 km",
            coordinate: CLLocationCoordinate2D(latitude: -8.7250, longitude: 115.2090),
            imagePlaceholderColor: "brown"
        )
    ]
}
