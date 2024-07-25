//
//  AudioTrack.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
struct AudioTrack :Codable {
    let id : String
    let name : String
    let album : Album
    let artists : [Artist]
    let available_markets : [String]
    let popularity : Int
    let disc_number : Int
    let duration_ms : Int
    let explicit : Bool
    let external_urls : [String : String]
}
