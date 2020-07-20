//
//  ContentView.swift
//  Table
//
//  Created by Lukáš Hromadník on 20/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

struct ColumnWidthPreference: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int : CGFloat], nextValue: () -> [Int : CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

struct RowHeightPreference: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int : CGFloat], nextValue: () -> [Int : CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

extension View {
    func geometryPreference<Key: PreferenceKey>(_ key: Key.Type, value: @escaping (GeometryProxy) -> Key.Value) -> some View {
        overlay(
            GeometryReader { proxy in
                Color.clear.preference(key: key.self, value: value(proxy))
            }
        )
    }
}

struct Table<Content: View>: View {
    var cells: [[Content]]
    
    @State private var columnWidths: [Int: CGFloat] = [:]
    @State private var rowHeights: [Int: CGFloat] = [:]
    @State private var selection: (row: Int, column: Int)?
    
    private func cell(row: Int, col: Int) -> some View {
        cells[row][col]
            .frame(width: self.columnWidths[col], height: self.rowHeights[row], alignment: .topLeading)
            .border(self.selection?.row == row && self.selection?.column == col ? Color.accentColor : Color.clear, width: 2)
    }

    var body: some View {
        VStack {
            ForEach(cells.indices) { row in
                HStack {
                    ForEach(self.cells[row].indices) { col in
                        self.cell(row: row, col: col)
                            .geometryPreference(ColumnWidthPreference.self) { [col: $0.size.width] }
                            .geometryPreference(RowHeightPreference.self) { [row: $0.size.height] }
                            .onTapGesture {
                                self.selection = (row: row, column: col)
                            }
                    }
                }
            }
        }
        .onPreferenceChange(ColumnWidthPreference.self) { self.columnWidths = $0 }
        .onPreferenceChange(RowHeightPreference.self) { self.rowHeights = $0 }
    }
}

struct ContentView: View {
    var cells = [
        [Text(""), Text("Monday").bold(), Text("Tuesday").bold(),
         Text("Wednesday").bold()],
        [Text("Berlin").bold(), Text("Cloudy"), Text("Mostly\nSunny"), Text("Sunny")],
        [Text("London").bold(), Text("Heavy Rain"), Text("Cloudy"), Text("Sunny")],
    ]
    var body: some View {
        Table(cells: cells)
            .font(Font.system(.body, design: .serif))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
