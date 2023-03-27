//
//  SetGame.swift
//  Set
//
//  Created by Omar Ahmed on 3/6/23.
//

import Foundation

class SetGame: ObservableObject {
    
    let numberOfSetGamesInANewGame = 12
    var deck = SetCardDeck()
    @Published public var cards = [SetCard]()
    @Published public var score = 0
    public var selectedCards = [SetCard]()
    
    // Function to deal a specified number of cards from the deck
    func dealCards(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            if let card = deck.dealCard() {
                cards.append(card)
            }
        }
    }
    
    // Function to handle card selection and game logic
    func selectCard(card: SetCard) {
        var chosenIndex: Int?
        
        // Find the index of the chosen card
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                chosenIndex = i
                break
            }
        }
        
        if let chosenIndex = chosenIndex {
            // If there are already 3 selected cards, check if they form a set
            if selectedCards.count == 3 {
                if isSet(cards: selectedCards) {
                    replaceMatchedCards()
                } else {
                    deselectNonMatchingCards()
                }
            }

            // If the card is not already matched, toggle its selection
            if !cards[chosenIndex].isMatched {
                cards[chosenIndex].isSelected = !cards[chosenIndex].isSelected

                // Update the list of selected cards
                if cards[chosenIndex].isSelected {
                    selectedCards.append(cards[chosenIndex])
                } else {
                    for i in 0..<selectedCards.count {
                        if selectedCards[i].id == cards[chosenIndex].id {
                            selectedCards.remove(at: i)
                            break
                        }
                    }
                    cards[chosenIndex].isMisMatched = false
                }
            }

            // If there are now 3 selected cards, check if they form a set
            if selectedCards.count == 3 {
                if isSet(cards: selectedCards) {
                    score += 3              //For Extra Credits
                    for selectedCard in selectedCards {
                        for i in 0..<cards.count {
                            if cards[i].id == selectedCard.id {
                                cards[i].isMatched = true
                                break
                            }
                        }
                    }
                } else {
                    score -= 2             //For Extra Credits
                    for selectedCard in selectedCards {
                        for i in 0..<cards.count {
                            if cards[i].id == selectedCard.id {
                                cards[i].isMisMatched = true
                                break
                            }
                        }
                    }
                }
            }
        }
    }

    // Function to replace matched cards with new cards from the deck
    private func replaceMatchedCards() {
        // Iterate through selected cards
        for selectedCard in selectedCards {
            var index: Int?
            // Find the index of the selected card in the cards array
            for i in 0..<cards.count {
                if cards[i].id == selectedCard.id {
                    index = i
                    break
                }
            }
            // Replace the matched card with a new card from the deck
            if let index = index, let newCard = deck.dealCard() {
                cards[index] = newCard
            }
        }
        // Clear the list of selected cards
        selectedCards.removeAll()
    }

    // Function to deselect non-matching cards and reset their isMisMatched property
    private func deselectNonMatchingCards() {
        // Iterate through selected cards
        for selectedCard in selectedCards {
            var selectedCardIndex: Int?
            // Find the index of the selected card in the cards array
            for i in 0..<cards.count {
                if cards[i].id == selectedCard.id {
                    selectedCardIndex = i
                    break
                }
            }
            // Deselect the card and reset its isMisMatched property
            if let selectedCardIndex = selectedCardIndex {
                cards[selectedCardIndex].isSelected = false
                cards[selectedCardIndex].isMisMatched = false
            }
        }
        // Clear the list of selected cards
        selectedCards.removeAll()
    }

    // Function to add 3 more cards from the deck
    func addThreeCards() {
        // If there are 3 selected cards, check if they form a set
        if selectedCards.count == 3 {
            if isSet(cards: selectedCards) {
                replaceMatchedCards()
            } else {
                deselectNonMatchingCards()
            }
        }
        // If the deck is not empty, deal 3 more cards
        if !deck.isEmpty() {
            dealCards(numberOfCards: 3)
        }
    }

    // Function to start a new game
    func newGame() {
        // Create a new deck and clear the cards array
        deck = SetCardDeck()
        cards.removeAll()
        
        // Clear the list of selected cards and reset the score
        selectedCards.removeAll()
        score = 0
        
        // Shuffle the deck and deal a new set of cards
        deck.deck.shuffle()
        dealCards(numberOfCards: numberOfSetGamesInANewGame)
    }

    // Function to check if a given array of cards forms a valid set
    public func isSet(cards: [SetCard]) -> Bool {
        // If there are not exactly 3 cards, return false
        if cards.count != 3 {
            return false
        }
        // Count unique properties of the cards
        let counts = Set([cards[0].count, cards[1].count, cards[2].count]).count
        let shapes = Set([cards[0].shape, cards[1].shape, cards[2].shape]).count
        let shades = Set([cards[0].shade, cards[1].shade, cards[2].shade]).count
        let colors = Set([cards[0].color, cards[1].color, cards[2].color]).count
        
        // If any property has exactly 2 unique values, it's not a set
        return counts != 2 && shapes != 2 && shades != 2 && colors != 2
    }
    
    // SetGame initializer
    init() {
        self.deck = SetCardDeck()
        dealCards(numberOfCards: numberOfSetGamesInANewGame)
    }

}
