//
//  ContentView.swift
//  Set
//
//  Created by Omar Ahmed on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetGame
    
    // Main view body
    var body: some View {
        VStack {
            // Display the current score at the top of the screen
            Text("Score: \(viewModel.score)")           //For Extra Credits
                .font(.title)
                .padding(.top)
            
            Spacer()
            
            // Use GeometryReader to create a responsive grid of cards
            GeometryReader { geometry in
                AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                    // Create and display individual card views
                    CardView(card: card)
                        .padding(1)
                        // Handle tap gesture to choose a card
                        .onTapGesture {
                            viewModel.selectCard(card: card)
                        }
                }
                .padding()
            }
            
            Spacer()
            
            // New game and deal 3 more cards buttons at the bottom of the screen
            HStack {
                Spacer()
                Button("New Game"){
                    viewModel.newGame()
                }
                Spacer()
                Button("Deal 3 More Cards") {
                    viewModel.addThreeCards()
                }
                .disabled(viewModel.deck.isEmpty())
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

// CardView struct for displaying a single card
struct CardView: View {
    let card: SetCard
    
    // Card view body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw card background and border
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.white)
                    .border(cardBorderColor(), width: 1)
                VStack {
                    // Display card symbols based on the card properties
                    ForEach(0..<3) { index in
                        if index < card.count {
                            card.getSymbol()
                                .foregroundColor(card.getCardColor())
                                .opacity(card.getCardShading())
                        }
                    }
                }
                // Set font size based on the card size
                .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.3))
            }
            .padding()
        }
    }
    
    // Determine card border color based on the card's state
    func cardBorderColor() -> Color {
        if card.isMatched {
            return .green
        } else if card.isMisMatched {
            return .red
        } else if card.isSelected {
            return .blue
        } else {
            return .black
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        Group {
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
        }
    }
}
