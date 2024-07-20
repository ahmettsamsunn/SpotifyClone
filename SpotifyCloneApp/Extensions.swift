//
//  Extensions.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
import UIKit
extension UIView {
    var widht : CGFloat {
        return frame.size.width
    }
    
    var height : CGFloat {
        return frame.size.height
    }
    
    var left : CGFloat {
        return frame.origin.x
    }
    
    var right : CGFloat {
        return left + widht
    }
    
    var top : CGFloat {
        return frame.origin.y
    }
    
    var bottom : CGFloat {
        return top + height
    }
}
