//
//  UserProfile.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
struct UserProfile : Codable {
    let country : String
    let display_name : String
    let email : String
    let explicit_content : [String : Bool]
    let external_urls : [String : String]
    let id : String
    let product : String
    let images : [userImage]?
    
    
}
struct userImage : Codable {
    let url : String
}

