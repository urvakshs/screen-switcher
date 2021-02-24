//
//  MusicCell.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/02/21.
//

import UIKit

class MusicCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var songLengthLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateView(song: Song) {
        songNameLabel.text = song.trackCensoredName
        //albumArtImageView.image = albumArt
        
        // Ensuring that the album art image looks good in the 100 px. x 100 px. square by setting the content mode to aspect fit
        albumArtImageView.contentMode = .scaleAspectFit
        
        // Create URL
        let url = URL(string: song.artworkUrl60!)!

        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            albumArtImageView.image = UIImage(data: data)
        }
        
        let songLengthInSeconds = Double(song.trackTimeMillis!) * 0.001
        let songLengthInMins = Int(songLengthInSeconds / 60)
        
        // Formatting the seconds with leading zeros in cases where there are only single-digit seconds after the minutes
        let remainingLengthInSeconds =  String(format: "%02d", Int(songLengthInSeconds) - (songLengthInMins * 60))
        songLengthLabel.text = String("\(songLengthInMins):\(remainingLengthInSeconds)")
        artistLabel.text = song.artistName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

