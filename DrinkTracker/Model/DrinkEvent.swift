//Created by Alexander Skorulis on 15/8/2025.

import Foundation
import CoreLocation

struct DrinkEvent {
    let id: UUID
    let time: Date
    let location: CLLocationCoordinate2D?
    let drink: Drink
    
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
    let photoID: String?
    
    // Name of the drink
    let name: String?
    
    // Size in mils
    let size: Int
    
    // % Strength
    let abv: Double
    
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
