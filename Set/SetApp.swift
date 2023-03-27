//
//  SetApp.swift
//  Set
//
//  Created by Omar Ahmed on 3/6/23.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetGame()
            ContentView(viewModel: game)
        }
    }
}
