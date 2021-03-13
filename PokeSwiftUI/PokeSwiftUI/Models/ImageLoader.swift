//
//  ImageLoader.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 2/28/21.
//  Copyright © 2021 Nicolas Combe. All rights reserved.
//

// MARK: - Inspirated from:
/// - https://github.com/Dimillian/MovieSwiftUI
/// - https://www.donnywals.com/efficiently-loading-images-in-table-views-and-collection-views/

import Combine
import UIKit

public final class ImageLoaderCache {

    public static let shared = ImageLoaderCache()
    private init () { }

    private var loaders: NSCache<NSString, ImageLoader> = {
        let cache = NSCache<NSString, ImageLoader>()
        cache.countLimit = 100 // 100 items
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()

    public func loaderFor(url: URL) -> ImageLoader {
        let key = NSString(string: url.absoluteString)

        if let loader = loaders.object(forKey: key) { return loader }
        else {
            let loader = ImageLoader(url: url)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }

    public func clearCache() {
        loaders.removeAllObjects()
        URLCache.shared.removeAllCachedResponses()
    }

}

public final class ImageLoader: ObservableObject {

    @Published public var image: UIImage?
    public var cancellable: AnyCancellable?

    public init(url: URL) {
        cancellable = ImageService.shared.fetchImage(url: url)
            .receive(on: DispatchQueue.main)
            .replaceError(with: UIImage(named: "noImage"))
            .assign(to: \.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }

}
