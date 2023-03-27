//
//  SetCard.swift
//  Set
//
//  Created by Omar Ahmed on 3/6/23.
//

import SwiftUI

// SetCard struct representing an individual card in the Set game
struct SetCard: Identifiable, Equatable {
    
    var shape: Shapes
    var shade: Shades
    var color: Colors
    var count: Int
    var isSelected: Bool
    var isMatched: Bool
    var isMisMatched: Bool
    var id: Int
    
    // Enum to represent the three different shapes for cards
    enum Shapes {
        case circle
        case square
        case diamond
        
        // An array containing all possible shapes
        static var all = [Shapes.circle, .square, .diamond]
    }
    
    // Enum to represent the three different shading types for cards
    enum Shades {
        case outlined
        case shaded
        case filled
        
        // An array containing all possible shading types
        static var all = [Shades.outlined, .shaded, .filled]
    }
    
    // Enum to represent the three different colors for cards
    enum Colors {
        case red
        case green
        case yellow
        
        // An array containing all possible colors
        static var all = [Colors.red, .green, .yellow]
    }
    
    // Function to return the appropriate symbol for the card's shape and shading
    func getSymbol() -> Text {
        switch shape {
        case .circle:
            switch shade {
            case .outlined:
                return Text("○")
            default:
                return Text("●")
            }
        case .square:
            switch shade {
            case .outlined:
                return Text("□")
            default:
                return Text("■")
            }
        case .diamond:
            switch shade {
            case .outlined:
                return Text("◇")
            default:
                return Text("◆")
            }
        }
    }

    // Function to return the appropriate color for the card's color property
    func getCardColor() -> Color {
        switch self.color {
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        }
    }
    
    // Function to return the appropriate opacity for the card's shading property
    func getCardShading() -> Double {
        switch self.shade {
        case .outlined:
            return 1.0
        case .shaded:
            return 0.3
        case .filled:
            return 1.0
        }
    }
    
    // SetCard initializer
    init(shape: Shapes, shade: Shades, color: Colors, count: Int, id: Int) {
        self.shape = shape
        self.shade = shade
        self.color = color
        self.count = count
        self.isSelected = false
        self.isMatched = false
        self.isMisMatched = false
        self.id = id
    }
}


