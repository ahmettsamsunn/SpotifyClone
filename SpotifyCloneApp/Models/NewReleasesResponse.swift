//
//  NewReleasesResponse.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 21.07.2024.
//

import Foundation
struct NewReleasesResponse : Codable {
    let albums : AlbumResponse
}
struct AlbumResponse : Codable {
    let items : [Album]
}
struct Album : Codable {
  
   let id: String
       let total_tracks: Int
       let album_type: String
        let images: [APIImage]
        let available_markets: [String]
        let name: String
        let release_date: String
     let artists: [Artist]
}

