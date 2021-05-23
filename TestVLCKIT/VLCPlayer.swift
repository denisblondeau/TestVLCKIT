//
//  VLCPlayer.swift
//  TestVLCKIT
//
//  Created by Denis Blondeau on 2021-05-21.
//

import SwiftUI
import VLCKit


/// VLC Player for SwiftUI.
struct VLCPlayer: NSViewRepresentable {
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private let player = VLCMediaPlayer()
    private var media: VLCMedia!
    
    
    /// Initalise VLC Player.
    /// - Parameter url: A valid URL for the streaming media.
    init(url: String) {
        let mediaURL = URL(string: url)
        if let mediaURL = mediaURL {
            media = VLCMedia(url: mediaURL)
            player.media = media
        }
    }
    
    func makeNSView(context: NSViewRepresentableContext<VLCPlayer>) -> VLCVideoView {
        let vlcView = VLCVideoView()
        player.drawable = vlcView
        player.media.delegate = context.coordinator
        player.libraryInstance.debugLoggingTarget = context.coordinator
        
        NotificationCenter.default.addObserver(forName: NSApplication.willTerminateNotification, object: nil, queue: .main) {  _ in
            if player.isPlaying {
                player.stop()
            }
        }
        
        return vlcView
        
    }
    
    func updateNSView(_ vlcView: VLCVideoView, context: NSViewRepresentableContext<VLCPlayer>) {
        
        
    }
    
    class Coordinator: NSObject, VLCLibraryLogReceiverProtocol, VLCMediaDelegate {
        
        var parent:  VLCPlayer
        
        init(_ parent: VLCPlayer) {
            self.parent = parent
        }
        
        func handleMessage(_ message: String, debugLevel level: Int32) {
            
            // Only print out errors.
            if (level == 4) {
                print("Player Error: \(message)")
                
            }
            
        }
        
        func mediaDidFinishParsing(_ aMedia: VLCMedia) {
            
            //            print(aMedia.tracksInformation)
        }
        
        func mediaMetaDataDidChange(_ aMedia: VLCMedia) {
            //            print(aMedia.tracksInformation)
        }
    }
}

extension VLCPlayer {
    
    /// Start media streaming.
    func play() {
        
        if !player.isPlaying {
            player.play()
        }
    }
    
    
    /// Stop media streaming.
    func stop() {
        if player.isPlaying {
            player.stop()
        }
    }
    
}



