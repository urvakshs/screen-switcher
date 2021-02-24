//
//  Song.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/02/21.
//

import UIKit

struct SearchData: Decodable {
    let resultCount: Int?
    let results: [Song]
}

struct Song: Decodable {
    let trackCensoredName: String?
    let trackTimeMillis: Int?
    let artistName: String?
    let artworkUrl60: String?

}
