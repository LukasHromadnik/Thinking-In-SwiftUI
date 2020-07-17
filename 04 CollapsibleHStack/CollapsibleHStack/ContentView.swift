//
//  ContentView.swift
//  CollapsibleHStack
//
//  Created by Lukáš Hromadník on 17/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var expanded = true
    
    var body: some View {
        VStack {
            CollapsibleHStack(
                data: [
                    Rectangle().fill(Color.red).frame(width: 80, height: 80),
                    Rectangle().fill(Color.green).frame(width: 60, height: 60),
                    Rectangle().fill(Color.blue).frame(width: 100, height: 100)
                ],
                expanded: expanded,
                content: { $0 },
                spacing: 20,
                verticalAlignment: .top
            )
            Toggle(isOn: $expanded.animation()) { Text("Expanded") }
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
