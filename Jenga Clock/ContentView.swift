//
//  ContentView.swift
//  Jenga Clock
//
//  Created by Adam Kopeć on 22/04/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var playerA = 0
    @State var playerZ = 0
    
    @State var playerAsTurn = false
    @State var playerZsTurn = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var dragValue: DragGesture.Value?
    @State var shouldShowCancel = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                if playerAsTurn {
                    VStack {
                        Spacer()
                        Text(playerA.asString(style: .positional))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width)
                        Spacer()
                    }
                    .background((playerA == 0 ? Color.red : playerA < 30 ? Color.orange : Color.green))
                    .frame(width: geometry.size.width)
                } else {
                    VStack {
                        Spacer()
                        Text(playerA.asString(style: .positional))
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: geometry.size.width)
                        Spacer()
                    }
                    .background()
                    .onTapGesture {
                        if playerAsTurn == playerZsTurn {
                            playerAsTurn = true
                        }
                    }
                }
                if playerZsTurn {
                    VStack {
                        Spacer()
                        Text(playerZ.asString(style: .positional))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width)
                        Spacer()
                    }
                    .background((playerZ == 0 ? Color.red : playerZ < 30 ? Color.orange : Color.green))
                    .frame(width: geometry.size.width)
                } else {
                    VStack {
                        Spacer()
                        Text(playerZ.asString(style: .positional))
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: geometry.size.width)
                        Spacer()
                    }
                    .background()
                    .onTapGesture {
                        if playerAsTurn == playerZsTurn {
                            playerZsTurn = true
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
//            .simultaneousGesture(TapGesture().onEnded({
            .gesture(TapGesture().onEnded({
                if playerAsTurn == playerZsTurn { return }
                if playerA == 0 || playerZ == 0 {
                    presentationMode.wrappedValue.dismiss()
                }
                playerAsTurn.toggle()
                playerZsTurn.toggle()
            }))
        }.onReceive(timer) { _ in
            if playerAsTurn, playerA > 0 {
                playerA -= 1
            }
            if playerZsTurn, playerZ > 0 {
                playerZ -= 1
            }
            if playerA == 0 || playerZ == 0 {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        }
        .ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert("Do you want to end this game?", isPresented: $shouldShowCancel) {
            Button("End game", role: .destructive) { }
        }
    }
    
    init(startingTime: Int, shouldAPlayerStart: Bool = false) {
        _playerA = State(initialValue: startingTime)
        _playerZ = State(initialValue: startingTime)
        
        if shouldAPlayerStart {
            if Int.random(in: 0...1) == 0 {
                _playerAsTurn = State(initialValue: true)
            } else {
                _playerZsTurn = State(initialValue: true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(startingTime: 0)
    }
}

extension Int {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = style
        return formatter.string(from: Double(self)) ?? ""
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
