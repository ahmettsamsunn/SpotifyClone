//
//  Models.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 19.07.2024.
//

import Foundation
struct Section {
    let title : String
    let option : [Option]
}
struct Option {
    let title : String
    let handler : () -> Void
}
