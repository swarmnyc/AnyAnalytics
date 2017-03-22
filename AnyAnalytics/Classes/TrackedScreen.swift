//
//  TrackedScreen.swift
//  trackerTest
//
//  Created by Alex Hartwell on 3/21/17.
//  Copyright © 2017 SWARM. All rights reserved.
//

import Foundation


/// For when it doesn't make sense to add the protocol to a view controller, you can create a standalone screen object
open class TrackedScreenStandaloneObject: TrackedScreen {
    public var analyticsName: String {
        return self.name
    }
    
    var name: String = ""
    
    public init(name: String) {
        self.name = name
    }
}

public protocol TrackedScreen {
    var analyticsName: String { get }
}

