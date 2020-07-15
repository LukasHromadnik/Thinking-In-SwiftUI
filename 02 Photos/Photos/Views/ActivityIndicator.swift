//
//  ActivityIndicator.swift
//  Chapter2 (iOS)
//
//  Created by Lukáš Hromadník on 11/07/2020.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        return view
    }
}
