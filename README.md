# AnyAnalytics

A analytics wrapper inspired by Moya that allows you to easily change the analytics provider you want to use.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AnyAnalytics is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AnyAnalytics", :git => 'https://github.com/swarmnyc/AnyAnalytics'
```

## Example

```swift
//
// organize the data you are tracking all in one place or split tracking up into different sections
//

enum AnalyticsEvents {
	case navigatedToScreen(screen: TrackedScreen)
	case pressedButton(buttonName: String)
	case watchedVideo(amountWatched: Double, videoId: String)
}

enum AnalyticsEvents: TrackerEvent {
	public var eventName: String {
		switch self {
		case .navigatedToScreen(let screen):
			return "Screen View \(screen.analyticsName)"
		case .pressedButton(let buttonName):
			return "buttonPress:\(buttonName)"
		case .watchedVideo( _, let videoId):
			return "watchedVideo:\(videoId)"
		}
	}
	
	public var metaData: [String: Any]? {
		switch self {
			case .navigatedToScreen(let screen):
				return nil
			case .pressedButton( _):
				return nil
			case .watchedVideo(let amountWatched, _):
				return ["amountWatched": amountWatched]
		}
	}
	
	public var type: EventTypes {
		switch self {
			case .navigatedToScreen( _):
				return .screen
			case .pressedButton( _):
				return .event
			case .watchedFullVideo( _):
				return .event
		}
	}
}

//
// Call an event like this:
//

AnalyticsEvent.pressedButton(buttonName: "login").track(withTracker: SegmentIOTracker())

//
//A blank tracker for testing (doesn't send data anywhere)
//

public class EmptyTracker: TrackerImplementation {

     open func trackScreen(_ event: TrackerEvent) {
        
    }
    
    open func trackEvent(_ event: TrackerEvent) {
        
    }
    
    open func timeEvent(_ event: TrackerEvent) {
        
    }
    
    open func customTracking(_ event: TrackerEvent) {
        
    }
    
}

//an example SegmentIO tracker 


class SegmentIOTracker: TrackerImplementation {
    
    init(withWriteKey writeKey: String) {
        let configuration = SEGAnalyticsConfiguration(writeKey: writeKey)
        configuration.trackApplicationLifecycleEvents = true
        SEGAnalytics.setup(with: configuration)
    }
    
    func trackScreen(_ event: TrackerEvent) {
        SEGAnalytics.shared().screen(event.eventName, properties: event.metaData)
    }
    
    func trackEvent(_ event: TrackerEvent) {
        SEGAnalytics.shared().track(event.eventName, properties: event.metaData)
    }
    
    func timeEvent(_ event: TrackerEvent) {
        //didn't implement this
    }
    
    func customTracking(_ event: TrackerEvent) {
        //didn't implement this, use any other type of tracking they offer here
    }
}


```


## Author

ahartwel, hartwellalex@gmail.com

## License

AnyAnalytics is available under the MIT license. See the LICENSE file for more info.
