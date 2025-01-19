//
//  ContentView.swift
//  timer
//
//  Created by Ruziev Bakhtiyor on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timer = PomodoroTimer(workDuration:25 * 60, breakDuration: 5 * 60)
    
    var body: some View {
        VStack {
            
            Text(timeString())
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(timer.isWorkSession ? "Work Session" : "Break Time")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor( timer.isWorkSession ? .red : .green)
            ProgressView(value: timeToProgress())
                .tint(timer.isWorkSession ? .red : .green)
            HStack {
                Button(timer.isRunning ? "Pause" : "Start") {
                    if timer.isRunning {
                        timer.pause()
                        return
                    }
                    timer.start()
                }
                
                Button("Reset") {
                    timer.reset()
                }
            }
    
            
        }
        .padding(10)
        .fixedSize()
        
    }
    
    private func timeToProgress() -> Double {
        let totalSeconds = timer.isWorkSession ? timer.workDuration : timer.breakDuration
        return Double(timer.secondLeft) / Double(totalSeconds)
        
    }
    
    private func timeString() -> String {
        let seconds = timer.secondLeft
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    ContentView()
}


