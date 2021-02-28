//
//  ImageService.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 2/28/21.
//  Copyright © 2021 Nicolas Combe. All rights reserved.
//

import UIKit
import Combine

public class ImageService {

    public static let shared = ImageService()

    private init() { }

    public func fetchImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, _) -> UIImage? in
                return UIImage(data: data)
            }.catch { error in
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }

}
