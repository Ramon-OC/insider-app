//
//  ThemeRevealModel.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//

import Foundation

extension ThemeRevealView{
    
    class ViewModel: ObservableObject{
        
        var words: [(String, String)] = []
        var currentWordIndex: Int = 0 // to highlight in red the word in the card
        var leaderName: String = ""
        
        @Published var isLocked: Bool = true // instuctions to flip card
                
        // MARK: assets - strings and figures names
        let backImage = "eye.fill"
        var lockWordCardTxt01: String { NSLocalizedString("themereveal06-string", comment: "greating")+leaderName+"!"}
        let lockWordCardTxt02 = NSLocalizedString("themereveal01-string", comment: "instructions")
        let wordsCardTxt01 = NSLocalizedString("themereveal02-string", comment: "leaderTap-message")
        let wordsCardTxt02 = NSLocalizedString("themereveal03-string", comment: "insiderTap-message")
        let wordsCardTxt03 = NSLocalizedString("themereveal04-string", comment: "timeOver-message")
        let wordsCardTxt04 = NSLocalizedString("themereveal05-string", comment: "generalTap-message")

        
        // MARK: words card view
        @Published  var isFlipped = false       // for flipping all the card
        @Published  var isPulsing = false       // for 'tap to flip/hide' text
        @Published  var lockFlip = false        // block the flip operation
        @Published  var beginCountdown = false  // start the timer
        
        init(){
            self.words = GameLogic.shared.getWordsFromCard()
            self.currentWordIndex  = GameLogic.shared.currentWordIndex ?? 0
            self.leaderName = GameLogic.shared.getMasterName()
        }
        
        func getBackgroundColor() -> String{
            if(beginCountdown){ return "InsiderRed"}
            return isFlipped ? "InsiderWhite": "InsiderBlack"
        }
        
        func flipCard(){
            if(!isFlipped && !beginCountdown){
                isFlipped = true
            }else{
                beginCountdown = true
                isFlipped = false
                lockFlip = true
            }
        }
        

        // MARK: Timer
        let durationSeconds: Int = 3
        @Published var duration: Duration = .seconds(3)
        @Published var mode: TimerMode = .CountDown
        @Published var isTimingStarted: Bool = false
        @Published var scaleCircle: Bool = false
        @Published var showNextViewText: Bool = false
        
        private var timer: Timer? = nil
        
        func startTimer() {
            if !isTimingStarted {
                if mode == .CountDown {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        self.duration -= .seconds(1)
                        if self.duration == .zero {
                            self.stopTimer()
                        }
                    }
                } 
                
                isTimingStarted = true
            }
        }
        
        func stopTimer() {
            if isTimingStarted {
                timer?.invalidate()
                timer = nil
                isTimingStarted = false
                scaleCircle = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { self.showNextViewText = true }
            }
        }
        
        func timerMessage() -> String {
            return scaleCircle ? wordsCardTxt03 : duration.formatted(.time(pattern: .hourMinuteSecond(padHourToLength: 2)))
        }
        
        // default initializer for the preview
        init(words: [(String, String)], currentWordIndex: Int, leaderName: String) {
            self.words = words
            self.currentWordIndex = currentWordIndex
            self.leaderName = leaderName
        }
    }
}

enum TimerMode {
    case CountDown
    case CountUp
}
