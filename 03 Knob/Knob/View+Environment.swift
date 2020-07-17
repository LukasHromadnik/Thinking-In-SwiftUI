//
//  View+Environment.swift
//  Knob
//
//  Created by Lukáš Hromadník on 17/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        environment(\.knobPointerSize, size)
    }

    func knobColor(_ color: Color) -> some View {
        environment(\.knobColor, color)
    }
}
