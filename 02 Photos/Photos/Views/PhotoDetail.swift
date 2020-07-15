//
//  PhotoDetail.swift
//  Chapter2 (iOS)
//
//  Created by Lukáš Hromadník on 11/07/2020.
//

import SwiftUI

struct PhotoDetail: View {
    var photo: Photo
    @ObservedObject var network: Remote<UIImage>
    
    init(photo: Photo) {
        self.photo = photo
        self.network = Remote(url: photo.downloadURL, decode: { UIImage(data: $0)! })
    }
    
    var body: some View {
        VStack {
            Group {
                if network.result == nil {
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(ActivityIndicator())
                } else {
                    Image(uiImage: network.result!)
                        .resizable()
                }
            }.aspectRatio(CGFloat(photo.width)/CGFloat(photo.height), contentMode: .fit)
            Text(photo.author)
        }
    }
}
