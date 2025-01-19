//
//  Timer.swift
//  timer
//
//  Created by Ruziev Bakhtiyor on 19.01.25.
//
import SwiftUI
import AVFoundation

class PomodoroTimer: ObservableObject {
    @Published var secondLeft = 0
    @Published var isRunning = false
    @Published var isWorkSession = false
    
    
    private var timer: Timer?
    private var workSound: AVAudioPlayer?
    private var breakSound: AVAudioPlayer?
    
    var workDuration: Int
    var breakDuration: Int
    
    
    init(workDuration: Int, breakDuration : Int) {
        self.workDuration = workDuration
        self.breakDuration = breakDuration
        self.reset()
        setupAudioPlayer()
        
    }
    
    private func setupAudioPlayer() {
        // Setup work session sound
        if let workSoundURL = Bundle.main.url(forResource: "work", withExtension: "mp3") {
            do {
                workSound = try AVAudioPlayer(contentsOf: workSoundURL)
                workSound?.prepareToPlay()
            } catch {
                print("Error loading work sound: \(error.localizedDescription)")
            }
        }
        
        // Setup break session sound
        if let breakSoundURL = Bundle.main.url(forResource: "break", withExtension: "mp3") {
            do {
                breakSound = try AVAudioPlayer(contentsOf: breakSoundURL)
                breakSound?.prepareToPlay()
            } catch {
                print("Error loading break sound: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Play specific sounds
    func playWorkSound() {
        workSound?.play()
    }
    
    func playBreakSound() {
        breakSound?.play()
    }
    
    func start() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.trigger()
        }
    }
    
    func trigger() {
        self.secondLeft -= 1
        if self.secondLeft <= 0 {
            if self.isWorkSession {
                playBreakSound()
                self.secondLeft = self.breakDuration
                self.isWorkSession = false
                return
            }
            playWorkSound()
            self.secondLeft = self.workDuration
            self.isWorkSession = true
            
        }
        
    }
    
    func pause() {
        self.isRunning = false
        self.timer?.invalidate()
    }
    
    
    func reset() {
        secondLeft = workDuration
        isRunning = false
        isWorkSession = true
        self.timer?.invalidate()
    }
    
}
