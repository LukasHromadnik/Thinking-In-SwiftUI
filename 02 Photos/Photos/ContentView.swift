//
//  ContentView.swift
//  Solution
//
//  Created by Lukáš Hromadník on 14/07/2020.
//  Copyright © 2020 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var network = Remote<[Photo]>(url: URL(string: "https://picsum.photos/v2/list")!)
    
    var body: some View {
        PhotosList(photos: network.result ?? [])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
