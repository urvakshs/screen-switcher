//
//  audioPlayerVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 25/02/21.
//

import UIKit
import AVFoundation

class audioPlayerVC: UIViewController {
    var urlString: String?
    var avPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let previewString = urlString {
            if let url = URL(string: previewString) { // Force unwrapped because I can guarantee that it will not be nil
                // Fetch Music Data
                if let data = try? Data(contentsOf: url) {
                    do {
                        avPlayer = try AVAudioPlayer(data: data)
                        if let player = avPlayer {
                            player.volume = 1.0
                            player.prepareToPlay()
                            player.play()
                        }
                    } catch {
                        print("Error creating or playing back from AVAudioPlayer. \(error.localizedDescription)")
                    }
                
                }
            }
        }
    }
}
