//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct AlcoholCalculator {
 
    static func grams(ml: Double, abv: Double) -> Double {
        let gravity: Double = 0.789
        return ml * (abv / 100) * gravity
    }
    
    // Only supports Australia for now
    static func stdDrinks(ml: Double, abv: Double) -> Double {
        return grams(ml: ml, abv: abv) / 10
    }
    
    static func stdDrinks(drink: Drink) -> Double {
        return stdDrinks(ml: Double(drink.size), abv: drink.abv)
    }
    
    static func grams(drink: Drink) -> Double {
        grams(ml: Double(drink.size), abv: drink.abv)
    }
    
    static func grams(drinks: [Drink]) -> Double {
        return drinks.map { grams(drink: $0) }.reduce(0, +)
    }
    
    static func bac(session: DrinkingSession, weight: Double = 85) -> Double {
        let seconds = session.endTime.timeIntervalSince1970 - session.startTime.timeIntervalSince1970
        let alcoholGrams = session.events.map { grams(drink: $0.drink) }.reduce(0, +)
        let hours = seconds / 3600
        return AlcoholCalculator.bac(alcoholGrams: alcoholGrams, hours: hours)
    }
    
    static func bac(
        alcoholGrams: Double,
        weight: Double = 85,
        hours: Double = 0
    ) -> Double {
        let weightGrams = weight * 1000
        let genderFactor: Double = 0.68
        let startingBAC = 100 * alcoholGrams / (weightGrams * genderFactor)
        let eliminationRate = 0.015
        return startingBAC - hours * eliminationRate
    }
}
