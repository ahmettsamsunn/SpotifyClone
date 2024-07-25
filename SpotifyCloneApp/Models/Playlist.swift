//
//  Playlist.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
struct Playlist : Codable {
    let description: String
    let id : String
    let owner : User
    let name : String
    let external_urls : [String : String]
    let images : [APIImage]
}
