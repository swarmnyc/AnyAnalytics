//
//  Tracker.swift
//  trackerTest
//
//  Created by Alex Hartwell on 3/21/17.
//  Copyright © 2017 SWARM. All rights reserved.
//

import Foundation
import Analytics


public protocol Tracker {
    /// Track an event, will call the appropriate methods inside of the Tracker object
    ///
    /// - Parameter event: a tracker event
    func track(_ event: TrackerEvent)
}


public protocol TrackerSendMethods {
    func trackScreen(_ event: TrackerEvent)
    func trackEvent(_ event: TrackerEvent)
    func timeEvent(_ event: TrackerEvent)
    func customTracking(_ event: TrackerEvent)
}


public protocol TrackerImplementation: Tracker, TrackerSendMethods {
    
}

