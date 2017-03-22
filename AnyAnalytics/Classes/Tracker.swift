//
//  Tracker.swift
//  trackerTest
//
//  Created by Alex Hartwell on 3/21/17.
//  Copyright © 2017 SWARM. All rights reserved.
//

import Foundation


public protocol Tracker {
    /// Track an event, will call the appropriate methods inside of the Tracker object
    ///
    /// - Parameter event: a tracker event
    func track(_ event: TrackerEvent)
}

public extension TrackerImplementation {
    func track(_ event: TrackerEvent) {
        switch event.type {
        case .screen:
            self.trackScreen(event)
        case .event:
            self.trackEvent(event)
        case .timing:
            self.timeEvent(event)
        case .custom(let key):
            self.customTracking(event, key: key)
        }
    }
}

public protocol TrackerSendMethods {
    func trackScreen(_ event: TrackerEvent)
    func trackEvent(_ event: TrackerEvent)
    func timeEvent(_ event: TrackerEvent)
    func customTracking(_ event: TrackerEvent, key: String)
}


public protocol TrackerImplementation: Tracker, TrackerSendMethods {
    
}

