//
//  SetCardDeck.swift
//  Set
//
//  Created by Omar Ahmed on 3/6/23.
//

import Foundation

// SetCardDeck struct representing a deck of Set cards
struct SetCardDeck {
    
    var deck = [SetCard]()
    
    // Function to return the count of cards in the deck
    func count() -> Int {
        deck.count
    }
    
    // Function to check if the deck is empty
    func isEmpty() -> Bool {
        deck.count == 0
    }
    
    // Function to deal a card from the deck, removing it from the deck
    mutating func dealCard() -> SetCard? {
        if isEmpty() {
            return nil
        } else {
            return deck.remove(at: 0)
        }
    }
    
    // SetCardDeck initializer
    init() {
        var id = 1
        // Loop through all possible card properties to create a full deck
        for color in SetCard.Colors.all {
            for shape in SetCard.Shapes.all {
                for shade in SetCard.Shades.all {
                    for count in 1...3 {
                        // Add a new SetCard to the deck with the current properties
                        deck += [SetCard(
                            shape: shape,
                            shade: shade,
                            color: color,
                            count: count,
                            id: id)]
                        id += 1
                    }
                }
            }
        }
        // Shuffle the deck to randomize the card order
        deck.shuffle()
    }
}

