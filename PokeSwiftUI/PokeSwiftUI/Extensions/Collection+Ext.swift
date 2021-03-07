//
//  Collection+Ext.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 3/6/21.
//  Copyright © 2021 Nicolas Combe. All rights reserved.
//

import Foundation

extension Collection {

    /// Workaround to be able to use .enumerated on SwiftUI lists
    /// - Returns: .enumerated()
    func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
        Array(self.enumerated())
    }

}
