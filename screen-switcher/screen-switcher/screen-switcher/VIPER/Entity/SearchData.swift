//
//  SearchData.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 24/03/21.
//

import Foundation

struct SearchResults: Decodable {
    let resultCount: Int?
    let results: [SongDetails]
}

struct SongDetails: Decodable {
    let trackCensoredName: String?
    let trackTimeMillis: Int?
    let artistName: String?
    let artworkUrl60: String?
    let previewUrl: String?
}
