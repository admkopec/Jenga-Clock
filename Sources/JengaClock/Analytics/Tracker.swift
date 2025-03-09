//
//  Tracker.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 09/03/2025.
//

public protocol Tracker {
    func trackScreenView(screenName: String)
    func trackEvent(_ eventName: String, parameters: [String : Any]?)
}
