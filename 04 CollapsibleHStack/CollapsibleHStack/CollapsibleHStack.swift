//
//  CollapsibleHStack.swift
//  CollapsibleHStack
//
//  Created by Lukáš Hromadník on 17/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

struct CollapsibleHStack<Element, Content: View>: View {
    var data: [Element]
    var expanded: Bool = false
    var content: (Element) -> Content
    var spacing: CGFloat? = nil
    var verticalAlignment: VerticalAlignment = .center
    
    var body: some View {
        HStack(alignment: verticalAlignment, spacing: spacing) {
            ForEach(0..<data.count) { index in
                self.content(self.data[index])
                    .frame(width: (index < self.data.count - 1 && self.expanded == false) ? 10 : nil, alignment: .leading)
            }
        }
    }
}
