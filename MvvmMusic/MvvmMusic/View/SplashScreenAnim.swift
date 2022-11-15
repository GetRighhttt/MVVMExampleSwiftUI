//
//  SplashScreenAnim.swift
//  MvvmMusic
//
//  Created by Stefan Bayne on 11/15/22.
//

import SwiftUI

struct SplashScreenAnim: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            
            ContentView(viewModel: SongListViewModel())
            
            ZStack {
                Color("DarkGreen")
                Image(systemName: "music.note")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                    .foregroundColor(Color("Pale"))
                
                    .scaleEffect(animate ? 3 : 1)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea()
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            
            withAnimation(Animation.easeOut(duration: 0.55)) {
                animate.toggle()
            }
            
            withAnimation(Animation.easeIn(duration: 0.45)) {
                endSplash.toggle()
            }
        }
    }
}


struct SplashScreenAnim_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenAnim()
    }
}

