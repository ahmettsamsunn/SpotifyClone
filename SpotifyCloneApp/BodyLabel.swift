//
//  BodyLabel.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 20.07.2024.
//

import UIKit

class BodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(textAligment : NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAligment
       
        configure()
    }
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
