//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import KnitMacros
import SwiftUI

@Observable final class EditDrinkViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    var name: String = "" {
        didSet {
            drink.drink.name = name
        }
    }
    
    var abv: String = "" {
        didSet {
            drink.drink.abv = Double(abv) ?? 0
        }
    }
    
    var size: String = "" {
        didSet {
            drink.drink.size = Int(size) ?? 0
        }
    }
    
    var drink: DrinkEvent
    
    let title: String
    
    private var store: MainStore
    
    @Resolvable<DrinkTrackerResolver>
    init(@Argument drink: DrinkEvent?, store: MainStore) {
        self.store = store
        if let drink = drink {
            self.title = "Edit Drink"
            self.drink = drink
            self.name = drink.drink.name ?? ""
            self.abv = "\(drink.drink.abv)"
            self.size = "\(drink.drink.size)"
        } else {
            self.title = "Add Drink"
            self.drink = DrinkEvent(drink: .init(size: 0, abv: 0))
        }
    }
}

// MARK: - Logic

extension EditDrinkViewModel {
    
    func save() {
        var session: DrinkingSession = store.session(for: drink) ?? store.activeSession ?? DrinkingSession(events: [])
        session.update(drink: drink)
        store.update(session: session)
    }
    
    func close() {
        // TODO: Validate
        
        save()
        
        coordinator?.pop()
    }
}
