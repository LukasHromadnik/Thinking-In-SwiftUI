//
//  PhotosList.swift
//  Chapter2 (iOS)
//
//  Created by Lukáš Hromadník on 11/07/2020.
//

import Foundation
import SwiftUI

private let thumbnailWidth: CGFloat = 32

struct PhotoListItem: View {
    @ObservedObject var remote: Remote<UIImage>
    var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        self.remote = Remote<UIImage>(url: photo.thumbnailURL(width: Int(thumbnailWidth)), decode: { UIImage(data: $0)! })
    }
    
    var body: some View {
        NavigationLink(
            destination: PhotoDetail(photo: self.photo),
            label: {
                HStack {
                    Group {
                        if self.remote.result == nil {
                            Rectangle()
                                .overlay(Color.gray)
                                .opacity(0.1)
                                .overlay(ActivityIndicator())
                        } else {
                            Image(uiImage: remote.result!)
                                .resizable()
                        }
                    }
                    .cornerRadius(4)
                    .frame(width: thumbnailWidth, height: thumbnailWidth)
                    Text(photo.author)
                }
            }
        )
    }
}

struct PhotosList: View {
    var photos: [Photo]
    
    var body: some View {
        NavigationView {
            List(photos) { photo in
                PhotoListItem(photo: photo)
            }.navigationBarTitle("Photos")
        }
    }
}

struct PhotosList_Previews: PreviewProvider {
    static var previews: some View {
        PhotosList(photos: [
            Photo(
                id: "0",
                author: "Author",
                width: 100,
                height: 100,
                url: URL(string: "https://seznam.cz")!,
                downloadURL: URL(string: "https://seznam.cz")!
            )
        ])
    }
}
