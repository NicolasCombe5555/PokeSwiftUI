//
//  URL+Ext.swift
//  PokeSwiftUI
//
//  Created by nicolasCombe on 3/6/21.
//  Copyright © 2021 Nicolas Combe. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {

    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }

}
