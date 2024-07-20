//
//  Button.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 20.07.2024.
//



import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(backgroundcolor : UIColor , title : String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundcolor
        self.setTitle(title, for: .normal)
        configure()
    }
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func set(background : UIColor,title : String){
        self.backgroundColor = background
        setTitle(title, for: .normal)
    }
}
