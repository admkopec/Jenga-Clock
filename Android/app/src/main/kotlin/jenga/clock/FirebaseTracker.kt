package jenga.clock

import com.google.firebase.Firebase
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.analytics.analytics
import com.google.firebase.analytics.logEvent
import skip.lib.Dictionary

class FirebaseTracker: Tracker {
    override fun trackScreenView(screenName: String) {
        Firebase.analytics.logEvent(FirebaseAnalytics.Event.SCREEN_VIEW) {
            param(FirebaseAnalytics.Param.SCREEN_NAME, screenName)
            param(FirebaseAnalytics.Param.SCREEN_CLASS, "MainActivity")
        }
    }

    override fun trackEvent(eventName: String, parameters: Dictionary<String, Any>?) {
        Firebase.analytics.logEvent(eventName) {
            parameters?.forEach { (key, value) ->
                param(key, value.toString())
            }
        }
    }
}