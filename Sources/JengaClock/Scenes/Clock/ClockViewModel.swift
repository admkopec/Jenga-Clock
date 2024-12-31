// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  ClockViewModel.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 25/12/2024.
//

import SwiftUI
import Combine
#if !SKIP
import CoreHaptics
import AudioToolbox
#else
import android.media.__
import android.content.__
import android.view.__
import java.time.__
#endif

class ClockViewModel: ObservableObject {
    let timer = Timer.publish(every: 1, on: RunLoop.main, in: RunLoop.Mode.common).autoconnect()
    var cancellable: AnyCancellable?
    
    #if !SKIP
    @AppStorage("makeSounds")
    private var makeSounds = false
    @AppStorage("vibrateOnTimesUp")
    private var allowHaptics = true
    #else
    // This is necessary because Skip doesn't support @AppStorage in ViewModels
    private var makeSounds: Bool {
        UserDefaults.standard.bool(forKey: "makeSounds") ?? false
    }
    private var allowHaptics: Bool {
        UserDefaults.standard.bool(forKey: "vibrateOnTimesUp") ?? true
    }
    #endif

    // MARK: - State
    
    var playerA = 0
    var playerZ = 0
    
    @Published var playerATimeLeft = "00:00"
    @Published var playerZTimeLeft = "00:00"
    
    @Published var playerAsTurn = false
    @Published var playerZsTurn = false
    
    var playerAsBackground: Color {
        playerA == 0 ? Color.red : playerA < 30 ? Color.orange : Color.green
    }
    var playerZsBackground: Color {
        playerZ == 0 ? Color.red : playerZ < 30 ? Color.orange : Color.green
    }
    
    // MARK: - Actions
    
    func onAppearActions() {
        cancellable = timer.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.tick()
        }
    }
    
    func onDisappearActions() {
        cancellable?.cancel()
    }
    
    func switchTurns(dismiss: () -> Void) {
        if playerAsTurn == playerZsTurn { return }
        if playerA == 0 || playerZ == 0 {
            dismiss()
        } else {
            playerAsTurn = !playerAsTurn
            playerZsTurn = !playerZsTurn
            
            if allowHaptics {
                UIImpactFeedbackGenerator().impactOccurred()
            }
        }
    }
    
    func tick() {
        if playerAsTurn, playerA > 0 {
            playerA -= 1
            playerATimeLeft = formatTime(playerA)
        }
        if playerZsTurn, playerZ > 0 {
            playerZ -= 1
            playerZTimeLeft = formatTime(playerZ)
        }
        if playerA == 0 || playerZ == 0, allowHaptics {
            #if !SKIP
            if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            } else {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            #else
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
            #endif
        } else if playerAsTurn || playerZsTurn, makeSounds {
            #if !SKIP
            AudioServicesPlaySystemSound(1104)
            #else
            let context = ProcessInfo.processInfo.androidContext
            let audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            audioManager.playSoundEffect(AudioManager.FX_KEYPRESS_STANDARD)
            #endif
        }
    }
    
    func formatTime(_ time: Int) -> String {
#if !SKIP
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        return formatter.string(from: Double(time)) ?? ""
#else
        let duration = Duration.ofSeconds(time.toLong())
        let minutes = duration.toMinutes() % 60
        let seconds = duration.toSeconds() % 60
        return String.format("%02d:%02d", minutes, seconds)
#endif
    }
    
    // MARK: - Setup
    
    init(startingTime: Int, shouldPlayerStart: Bool) {
        playerA = startingTime
        playerZ = startingTime
        playerATimeLeft = formatTime(startingTime)
        playerZTimeLeft = formatTime(startingTime)
        
        if shouldPlayerStart {
            // TODO: Try to make it a little bit less random, so that it would change more often
            if Int.random(in: 0...1) == 0 {
                playerAsTurn = true
            } else {
                playerZsTurn = true
            }
        }
    }
}
