//
//  TrackerEvent.swift
//  trackerTest
//
//  Created by Alex Hartwell on 3/21/17.
//  Copyright © 2017 SWARM. All rights reserved.
//

import Foundation


public protocol TrackerEvent {
    var eventName: String { get }
    var metaData: [String: Any]? { get }
    var type: EventTypes { get }
    func track(withTracker tracker: Tracker)
}


public extension TrackerEvent {
    func track(withTracker tracker: Tracker) {
        tracker.track(self)
    }
}

public enum EventTypes {
    case screen
    case event
    case timing
    case custom(key: String)
    
    fileprivate var index: Int {
        switch self {
        case .screen:
            return 0
        case .event:
            return 1
        case .timing:
            return 2
        case .custom( _):
            return 3
        }
    }
}

public func ==(lhs: EventTypes, rhs: EventTypes) -> Bool {
    return lhs.index == rhs.index
}
