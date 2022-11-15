//
//  DataModels.swift
//  MvvmMusic
//
//  Created by Stefan Bayne on 11/15/22.
//

import Foundation
import SwiftUI

/*
 Creating our model classes from our response.
 
 Like in Android, the names should match the JSON result.
 
 These mimick the response we get from Itunes URL.
 url = https://itunes.apple.com/search?term=coldplay&entity=song
 */


struct SongResponseModel: Decodable {
    let songs: [SongModel]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}

struct SongModel: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    /*
     We need the response names to match the json response so we create an enum
     to specify the names.
     */
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName = "trackName"
        case artistName = "artistName"
        case artworkUrl = "artworkUrl60"
    }
}
