//
//  Analytics.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 09/03/2025.
//

public class Analytics {
    private static var tracker: Tracker?
    
    public static func showScreen(_ screen: String) {
        tracker?.trackScreenView(screenName: screen)
    }
    
    public static func event(_ named: String, parameters: [String: Any]? = nil) {
        tracker?.trackEvent(named, parameters: parameters)
    }
    
    public static func register(tracker: Tracker) {
        guard self.tracker == nil else { return }
        self.tracker = tracker
    }
    
    private init () { }
}
