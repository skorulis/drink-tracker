//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI
import Charts

// MARK: - Memory footprint

struct DrinkingSessionBACChart {
    let session: DrinkingSession
    let weight: Double = 85
}

// MARK: - Rendering

extension DrinkingSessionBACChart: View {
    
    var body: some View {
        Chart {
            ForEach(points) { point in
                LineMark(
                    x: .value("Time", point.date),
                    y: .value("BAC", point.bac)
                )
            }
        }
        .frame(height: 100)
    }
    
    var points: [Point] {
        var result: [Point] = []
        for i in 0..<session.events.count {
            let usedEvents = Array(session.events.prefix(i))
            if i > 0 {
                var beforeEvents = Array(session.events.prefix(i - 1))
                let timePoint = session.events[i].time
                beforeEvents.append(
                    DrinkEvent(
                        time: timePoint,
                        drink: Drink(size: 0, abv: 0)
                    )
                )
                let beforeBac = AlcoholCalculator.bac(events: beforeEvents, weight: weight)
                result.append(.init(bac: beforeBac, date: beforeEvents.last!.time))
            }
            
            let bac = AlcoholCalculator.bac(events: usedEvents, weight: weight)
            result.append(.init(bac: bac, date: session.events[i].time))
        }
        let finalBAC = AlcoholCalculator.bac(session: session, weight: weight, time: .end)
        result.append(.init(bac: finalBAC, date: session.endTime))
        return result
    }
}

extension DrinkingSessionBACChart {
    struct Point: Identifiable {
        let bac: Double
        let date: Date
        
        var id: Date { date }
    }
}

// MARK: - Previews

#Preview {
    DrinkingSessionBACChart(session: .testing)
}

