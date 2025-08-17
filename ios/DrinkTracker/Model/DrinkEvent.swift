//Created by Alexander Skorulis on 15/8/2025.

import Foundation
import CoreLocation

struct DrinkEvent: Identifiable {
    let id: UUID
    var time: Date
    var location: CLLocationCoordinate2D?
    var drink: Drink
    
    init(
        id: UUID = UUID(),
        time: Date = Date(),
        location: CLLocationCoordinate2D? = nil,
        drink: Drink
    ) {
        self.id = id
        self.time = time
        self.location = location
        self.drink = drink
    }
}

struct Drink {
    // Photo ID from the photo library
    var photoID: String?
    
    // Name of the drink
    var name: String?
    
    // Size in mils
    var size: Int
    
    // % Strength
    var abv: Double
    
    init(
        photoID: String? = nil,
        name: String? = nil,
        size: Int,
        abv: Double
    ) {
        self.photoID = photoID
        self.name = name
        self.size = size
        self.abv = abv
    }
    
}
