//
//  FeaturedPlaylistResponse.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 21.07.2024.
//

import Foundation
struct FeaturedPlaylist : Codable{
    let message : String
    let playlists : PlaylistResponse
}
struct PlaylistResponse : Codable{
    let items : [Playlist]
}

struct User : Codable{
    let id : String
    let display_name : String
    let external_urls : [String:String]
}



