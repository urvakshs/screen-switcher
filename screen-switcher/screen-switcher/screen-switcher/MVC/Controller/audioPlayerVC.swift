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
                        // Create a new AVAudioPlayer instance and optionally unwrap
                        avPlayer = try AVAudioPlayer(data: data)
                    } catch {
                        print("Error in creation of AVAudioPlayer: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let player = avPlayer {
            player.volume = 1.0 // Not sure if this line is necessary?
            player.prepareToPlay()
            player.play()
        }
    }
}
