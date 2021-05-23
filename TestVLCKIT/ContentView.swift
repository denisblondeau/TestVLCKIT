//
//  ContentView.swift
//  TestVLCKIT
//
//  Created by Denis Blondeau on 2021-05-19.
//


import SwiftUI


struct ContentView: View {
    
    let player = VLCPlayer(url: "rtsp://username:password@someFeedWebsite.com/liveFeed")
    
    var body: some View {
        
        VStack {
            
            player
                .frame(width: 960, height: 540, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack {
                
                Button("Play") {
                    player.play()
                }
                Button("Stop") {
                    player.stop()
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
