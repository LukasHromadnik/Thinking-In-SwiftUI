//
//  EnvironmentExtensions.swift
//  Knob
//
//  Created by Lukáš Hromadník on 17/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

fileprivate struct ColorKey: EnvironmentKey {
    static var defaultValue: Color? = nil
}

extension EnvironmentValues {
    var knobColor: Color? {
        get { self[ColorKey.self] }
        set { self[ColorKey.self] = newValue }
    }

    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }
}
