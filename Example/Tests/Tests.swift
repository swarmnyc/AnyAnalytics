import UIKit
import XCTest
import AnyAnalytics


enum TrackEvents {
    case navigatedToScreen(screen: TrackedScreen)
    case pressedButton(name: String)
    case watchedFullVideo(videoId: String)
    case coolCustomEvent(customData: String)
}

extension TrackEvents: TrackerEvent {
    public var eventName: String {
        switch self {
        case .navigatedToScreen(let screen):
            return screen.analyticsName + " navigate event"
        case .pressedButton(let name):
            return "buttonPress" + name
        case .watchedFullVideo(let videoId):
            return "watched full video " + videoId
        case .coolCustomEvent( _):
            return "name"
        }
    }
    
    var metaData: [String: Any]? {
            return nil
    }

    var type: EventTypes {
        switch self {
        case .navigatedToScreen( _):
            return .screen
        case .pressedButton( _):
            return .event
        case .watchedFullVideo( _):
            return .timing
        case .coolCustomEvent( _):
            return .custom(key: "customEventTypeKey")
        }
    }


    
}

class Tests: XCTestCase {
    var tracker = TestTracker()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class TestTracker: TrackerImplementation {
        var trackScreenCallback: ((TrackerEvent) -> Void)?
        var trackEventCallback: ((TrackerEvent) -> Void)?
        var timeEventCallback: ((TrackerEvent) -> Void)?
        var customTrackingCallback: ((TrackerEvent) -> Void)?
        
        func trackScreen(_ event: TrackerEvent) {
            self.trackScreenCallback?(event)
        }
        
        func trackEvent(_ event: TrackerEvent) {
            self.trackEventCallback?(event)
        }
        
        func timeEvent(_ event: TrackerEvent) {
            self.timeEventCallback?(event)
        }
        
        func customTracking(_ event: TrackerEvent, key: String) {
            self.customTrackingCallback?(event)
        }
        
    }
    
    
    
 
    
    func testTrackerObjectScreenEvent() {
        let exp = self.expectation(description: "track screen callback is called")
        tracker.trackScreenCallback = { event in
            XCTAssertEqual(event.eventName, "the coolest screen navigate event")
            XCTAssert(event.type == EventTypes.screen)
            exp.fulfill()
        }
        
        TrackEvents.navigatedToScreen(screen: TrackedScreenStandaloneObject(name: "the coolest screen")).track(withTracker: self.tracker)
        self.waitForExpectations(timeout: 0.3, handler: nil)
    }
    
    func testTrackerObjectEvent() {
        let exp = self.expectation(description: "event callback is called")
        tracker.trackEventCallback = { event in
            XCTAssertEqual(event.eventName, "buttonPresscool button")
            XCTAssert(event.type == EventTypes.event)
            exp.fulfill()
        }
        TrackEvents.pressedButton(name: "cool button").track(withTracker: self.tracker)
        self.waitForExpectations(timeout: 0.3, handler: nil)
    }
    func testTrackerObjectTimeEvent() {
        let exp = self.expectation(description: "time callback is called")
        tracker.timeEventCallback = { event in
            XCTAssertEqual(event.eventName, "watched full video 123")
            XCTAssert(event.type == EventTypes.timing)
            exp.fulfill()
        }
        TrackEvents.watchedFullVideo(videoId: "123").track(withTracker: self.tracker)
        self.waitForExpectations(timeout: 0.3, handler: nil)
    }
    
    func testTrackerObjectCustomTracking() {
        let exp = self.expectation(description: "time callback is called")
        tracker.customTrackingCallback = { event in
            XCTAssertEqual(event.eventName, "name")
            XCTAssert(event.type == EventTypes.custom(key: "custom key"))
            exp.fulfill()
        }
        TrackEvents.coolCustomEvent(customData: "what").track(withTracker: self.tracker)
        self.waitForExpectations(timeout: 0.3, handler: nil)
    }
    
    
    
}

