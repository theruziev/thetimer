//
//  timerApp.swift
//  timer
//
//  Created by Ruziev Bakhtiyor on 19.01.25.
//

import SwiftUI

@main
struct timerApp: App {
    @Environment(\.openWindow) var openWindow
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }
    
        .commandsRemoved()
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .appTermination) {
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q", modifiers: .command)
            }
            CommandGroup(replacing: .help) {
                Button("Help") {
                    openWindow(id: "about")
                }
            }
        }
       
        
        WindowGroup("About", id: "about") {
            AboutView()
        }
        .commandsRemoved()
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }
 
}



class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
