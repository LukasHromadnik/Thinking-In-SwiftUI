//
//  ContentView.swift
//  Badge
//
//  Created by Lukáš Hromadník on 17/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

struct BadgeColor: EnvironmentKey {
    static var defaultValue: Color? = nil
}

extension EnvironmentValues {
    var badgeColor: Color? {
        get { self[BadgeColor.self] }
        set { self[BadgeColor.self] = newValue }
    }
}

extension View {
    func badgeColor(_ color: Color) -> some View {
        environment(\.badgeColor, color)
    }
}

struct BadgeView: View {
    var count: Int
    @Environment(\.badgeColor) var color
    
    var body: some View {
        Circle()
            .fill(color ?? Color.red)
            .frame(width: 24, height: 24)
            .overlay(
                Text("\(count)")
                    .foregroundColor(Color.white)
                    .font(.footnote)
            )
    }
}

extension View {
    func badge(count: Int, alignment: Alignment = .topTrailing) -> some View {
        overlay(
            ZStack {
                if count > 0 {
                    BadgeView(count: count)
                        .animation(nil)
                        .transition(.scale)
                }
            }
            .badgeColor(.green)
            .alignmentGuide(alignment.horizontal) { print($0); return $0.width / 2 }
            .alignmentGuide(alignment.vertical) { print($0); return $0.height / 2 }
            , alignment: alignment
        )
    }
}

struct ContentView: View {
    @State var count: Int = 2
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding(10)
                .background(Color.gray)
                .badge(count: count)
            Stepper("Count", value: $count.animation())
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
