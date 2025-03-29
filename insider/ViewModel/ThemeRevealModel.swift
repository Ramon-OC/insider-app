//
//  ThemeRevealModel.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//

import Foundation

extension ThemeRevealView{
    
    class ViewModel: ObservableObject{
        
        @Published var isLocked: Bool = true
        
        var words: [(String, String)] = []
        var currentWordIndex: Int = 0
        var leaderName: String = ""
        
        //func toggleIsLocked(){ self.isLocked.toggle() }
        
        // MARK: lock view
        var lockWordCardTxt01: String {"Hello,\n"+leaderName+"!"}
        let lockWordCardTxt02 = "As a leader role in the game, when you slide the bar you will see the game word highlighted in red. When you finish, everyone closes their eyes (including you) and you leave your cell phone on the table. You will give the instruction to the insider to open his eyes and everyone counts from five to cero. The master will hide the word"
        
        // MARK: words card view
        @Published  var isFlipped = false // for flipping all the card
        @Published  var isPulsing = false // for 'tap to flip/hide' text
        @Published  var lockFlip = false
        @Published  var beginCountdown = false
        
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
        
        let backImage = "eye.fill"
        let wordsCardTxt01 = "Leader: tap to flip"
        let wordsCardTxt02 = "Insider: tap to hide"
        let wordsCardTxt03 = "Time Is Over"
        let wordsCardTxt04 = "tap here to go to next phase"


        // MARK: timer
        let secDur: Int = 3
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
        
        // For the previews
        init(words: [(String, String)], currentWordIndex: Int, leaderName: String) {
            self.words = words
            self.currentWordIndex = currentWordIndex
            self.leaderName = leaderName
        }
        
        init(){
            self.words = GameLogic.shared.getWordsFromCard()
            self.currentWordIndex  = GameLogic.shared.currentWordIndex ?? 0
            self.leaderName = GameLogic.shared.getMasterName()
        }
    }
}

enum TimerMode {
    case CountDown
    case CountUp
}
