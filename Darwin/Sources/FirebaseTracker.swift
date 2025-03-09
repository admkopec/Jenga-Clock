//
//  FirebaseTracker.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 09/03/2025.
//

import JengaClock
import FirebaseAnalytics

class FirebaseTracker: Tracker {
    func trackScreenView(screenName: String) {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [
                            AnalyticsParameterScreenName: screenName,
                            AnalyticsParameterScreenClass: screenName
                           ])
    }
    
    func trackEvent(_ eventName: String, parameters: [String : Any]?) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
    
    init(isAppClip: Bool = false) {
        if isAppClip {
            Analytics.setUserProperty("true", forName: "AppClip")
        }
    }
}
