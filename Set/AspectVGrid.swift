//
//  AspectVGrid.swift
//  Set
//
//  Created by Omar Ahmed on 3/22/23.
//
import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    // Properties
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    let maxColumnCount: Int = 5
    
    var body: some View {
        GeometryReader { geometry in
            // Calculate the width of the items based on available space and aspect ratio
            let width = widthThatFits(in: geometry.size)
            // Define the columns configuration
            let columns = [GridItem(.adaptive(minimum: width), spacing: 0)]
            // Check if scrolling should be enabled
            let isScrollable = shouldEnableScrolling(geometryWidth: geometry.size.width, geometryHeight: geometry.size.height, itemCount: items.count, aspectRatio: aspectRatio)

            // If scrolling is needed, use a ScrollView, otherwise just create the grid
            if isScrollable {
                ScrollView {
                    createGrid(columns: columns)
                }
            } else {
                createGrid(columns: columns)
            }
        }
    }
    
    // Helper function to create a grid with the specified columns configuration
    private func createGrid(columns: [GridItem]) -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(items) { item in
                // Apply the aspect ratio to the content
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    private func widthThatFits(in size: CGSize) -> CGFloat {
        var columnCount = 1
        var rowCount = items.count
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / aspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (items.count + (columnCount - 1)) / columnCount
        } while columnCount < items.count && columnCount < maxColumnCount
        
        if columnCount > items.count {
            columnCount = items.count
        } else if columnCount > maxColumnCount {
            columnCount = maxColumnCount
        }
        
        return floor(size.width / CGFloat(columnCount))
    }
    
    // Determine if scrolling should be enabled based on the grid dimensions
    private func shouldEnableScrolling(geometryWidth: CGFloat, geometryHeight: CGFloat, itemCount: Int, aspectRatio: CGFloat) -> Bool {
        // Find the width for each item (3 columns)
        let itemWidth = geometryWidth / 3.0
        
        // Find the height for each item using the aspect ratio
        let itemHeight = itemWidth / aspectRatio
        
        // Calculate the number of rows needed (3 columns)
        let rowCount = Int(ceil(Double(itemCount) / 3.0))
        
        // Find the total height of the grid
        let totalHeight = CGFloat(rowCount) * itemHeight
        
        // Check if scrolling should be enabled (if totalHeight is more than available height)
        return totalHeight > geometryHeight
    }
}
