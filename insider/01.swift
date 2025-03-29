//
//  01.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//

//import SwiftUI
//// Timer View Model
//@Observable
//class TimerViewModel {
//    var duration: Duration = .zero
//    var mode: TimerMode = .CountUp
//    var isTimingStarted: Bool = false
//    
//    private var timer: Timer? = nil
//    
//    func startTimer() {
//        if !isTimingStarted {
//            if mode == .CountDown {
//                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                    self.duration -= .seconds(1)
//                    if self.duration == .zero {
//                        self.stopTimer()
//                    }
//                }
//            } else {
//                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                    self.duration += .seconds(1)
//                }
//            }
//            
//            isTimingStarted = true
//        }
//    }
//    
//    func stopTimer() {
//        if isTimingStarted {
//            timer?.invalidate()
//            timer = nil
//            isTimingStarted = false
//        }
//    }
//    
//    func resetTimer() {
//        stopTimer()
//        duration = .zero
//    }
//}
//
//
//// Timer View
//enum TimerMode {
//    case CountDown
//    case CountUp
//}

//struct TimerView: View {
//    var timerViewModel: TimerViewModel
//    
//    let fontSize: CGFloat = 200
//    let fontDesign: Font.Design = .rounded
//    let fontWeight: Font.Weight = .bold
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(timerViewModel.duration.formatted(.time(pattern: .hourMinuteSecond(padHourToLength: 2))))
//                .font(.system(size: fontSize))
//                .fontWeight(fontWeight)
//                .fontDesign(fontDesign)
//                .animation(.snappy, value: timerViewModel.duration)
//                .contentTransition(.numericText())
//                .monospacedDigit()
//                .minimumScaleFactor(0.01)
//               
//        }
//    }
//}
//
//// Main View
//struct HomeView: View {
//    @State private var timerViewModel = TimerViewModel()
//    
//    var backgroundColor: Color {
//        timerViewModel.isTimingStarted ? .black : .white
//    }
//    
//    func singleTap() {
//        timerViewModel.startTimer()
//    }
//    
//    func doubleTap() {
//        timerViewModel.stopTimer()
//    }
//
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                Spacer()
//                VStack(alignment: .center) {
//                    Text("Just Focus")
//                        .fontDesign(.rounded)
//                        .font(.largeTitle)
//                        .bold()
//                    Spacer()
//                    TimerView(timerViewModel: timerViewModel)
//                        .foregroundStyle(timerViewModel.isTimingStarted ? .white : .black)
//                        .zIndex(100)
//                    Spacer()
//                    ZStack {
//                        Circle()
//                            .frame(width: 80, height: 80)
//                            .shadow(radius: 6)
//                            .scaleEffect(timerViewModel.isTimingStarted ? 20 : 1.0)
//                            .foregroundColor(.black)
//                            .overlay {
//                                if !timerViewModel.isTimingStarted {
//                                    Image(systemName: "arrowtriangle.forward.fill")
//                                        .foregroundStyle(timerViewModel.isTimingStarted ? .black : .white)
//                                        .font(.title)
//                                        .offset(x:2)
//                                }
//                            }
//                        
//                            .onTapGesture(count: 2) {
//                                doubleTap()
//                            }
//                            .onTapGesture(count: 1) {
//                                singleTap()
//                            }
//                        if timerViewModel.isTimingStarted {
//                           Text("Double tap to stop")
//                            .font(.subheadline)
//                               .foregroundStyle(.gray)
//                               .fontDesign(.rounded)
//                        }
//                    }
//                }
//                .padding()
//                .animation(.easeInOut, value: timerViewModel.isTimingStarted)
//                
//            }
//        }
//    }
//    
//}
//
//#Preview {
//    HomeView()
//}
