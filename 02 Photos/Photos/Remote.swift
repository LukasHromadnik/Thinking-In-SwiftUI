//
//  Remote.swift
//  Chapter2 (iOS)
//
//  Created by Lukáš Hromadník on 11/07/2020.
//

import Foundation
import UIKit
import Combine

fileprivate class RemoteCache {
    static var cache: [URL: Data] = [:]
}

final class Remote<Element>: ObservableObject {
    var result: Element? {
        didSet {
            subject.send()
        }
    }
    let url: URL
    let decode: (Data) throws -> Element
    var objectWillChange: AnyPublisher<Void, Never> = Publishers.Sequence(sequence: []).eraseToAnyPublisher()
    private let subject = PassthroughSubject<Void, Never>()
    
    init(url: URL, decode: @escaping (Data) throws -> Element) {
        self.url = url
        self.decode = decode
        self.objectWillChange = subject.handleEvents(receiveSubscription: { [weak self] sub in self?.load() })
            .eraseToAnyPublisher()
    }
    
    func load() {
        print(url)
        let request = URLRequest(url: url)
        
        if let cachedResponse = RemoteCache.cache[url] {
            print("Cache hit")
            self.result = try? self.decode(cachedResponse)
            return
        }
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { self.result = nil; return }
            
            RemoteCache.cache[self.url] = data
            
            let mappedObject = try? self.decode(data)
            
            DispatchQueue.main.async { [weak self] in
                self?.result = mappedObject
            }
        }
        task.resume()
    }
}

extension Remote where Element: Decodable {
    convenience init(url: URL) {
        self.init(url: url, decode: { try JSONDecoder().decode(Element.self, from: $0) })
    }
}
