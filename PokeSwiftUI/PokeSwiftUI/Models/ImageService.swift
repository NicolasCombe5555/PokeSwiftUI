//
//  ImageService.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 2/28/21.
//  Copyright © 2021 Nicolas Combe. All rights reserved.
//

import Combine
import UIKit

public class ImageService {

    public static let shared = ImageService()

    private init() { }

    public func fetchImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: url)
//            .print("debugging")
            .tryMap { UIImage(data: $0.data) }
            .timeout(.seconds(5), scheduler: DispatchQueue.main)
            .replaceError(with: UIImage(named: "noImage"))
            .share()
            .eraseToAnyPublisher()
    }

}
