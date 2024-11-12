//
//  PropertyBuilderCompatible.swift
//  Core
//
//  Created by 이원빈 on 11/12/24.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

public protocol PropertyBuilderCompatible {
    associatedtype Base
    var builder: PropertyBuilder<Base> { get }
}

public extension PropertyBuilderCompatible {
    var builder: PropertyBuilder<Self> {
        PropertyBuilder(self)
    }
}

extension NSObject: PropertyBuilderCompatible {}
