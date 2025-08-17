//Created by Alexander Skorulis on 16/8/2025.

import Numerics
import Testing
@testable import DrinkTracker

struct AlcoholCalculatorTests {

    @Test func grams() {
        #expect(AlcoholCalculator.grams(ml: 1000, abv: 10) == 78.9)
        #expect(AlcoholCalculator.grams(ml: 375, abv: 5).isApproximatelyEqual(to: 14.79, absoluteTolerance: 0.01))
    }
    
    @Test func standardDrinks() {
        #expect(AlcoholCalculator.stdDrinks(ml: 1000, abv: 10).isApproximatelyEqual(to: 7.89, absoluteTolerance: 0.01))
        #expect(AlcoholCalculator.stdDrinks(ml: 375, abv: 5).isApproximatelyEqual(to: 1.48, absoluteTolerance: 0.01))
        #expect(AlcoholCalculator.stdDrinks(ml: 375, abv: 6.1).isApproximatelyEqual(to: 1.8, absoluteTolerance: 0.01))
    }
    
    @Test func bac() {
        #expect(AlcoholCalculator.bac(alcoholGrams: 15.0, weight: 85).isApproximatelyEqual(to: 0.026, absoluteTolerance: 0.01))
        
        #expect(
            AlcoholCalculator.bac(alcoholGrams: 32.0, weight: 85, hours: 1)
                .isApproximatelyEqual(to: 0.042, absoluteTolerance: 0.01)
        )
    }

}
