//
//  HelpView.swift
//  timer
//
//  Created by Ruziev Bakhtiyor on 19.01.25.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("⌛")
                .font(Font.system(size: 50))
            
            Text("The Pomodoro Timer")
                .fontWeight(.bold)
            Spacer(minLength: 20)
            
            Text("Powered by").fontWeight(.bold)
            Text("https://theruziev.com")
        }
        .padding(10)
        .fixedSize()
    }
}


#Preview {
    AboutView()
}
