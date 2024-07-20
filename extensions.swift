//
//  extensions.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 20.07.2024.
//

import Foundation
import UIKit
 extension  UIViewController {
     func presentGFAlertOnMainThread(title : String,message : String,buttontitle : String) {
         DispatchQueue.main.async {
             let alertVC = AlertVC(alerttitle: title, message: message, buttontitle: buttontitle)
             alertVC.modalPresentationStyle = .overFullScreen
             alertVC.modalTransitionStyle = .crossDissolve
             self.present(alertVC, animated: true)
         }
     }
}
