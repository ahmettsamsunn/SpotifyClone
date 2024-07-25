//
//  Artist.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
