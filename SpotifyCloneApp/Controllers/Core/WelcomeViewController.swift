//
//  WelcomeViewController.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Spotify"
        view.addSubview(button)
        button.addTarget(self, action: #selector(didtapSignIn), for: .touchUpInside)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.widht-40, height: 50)
    }

    @objc func didtapSignIn(){
        let vc = AuthViewController()
        vc.completionhandler = { [weak self] success in
            guard let self = self else {
                return
            }
            self.handelesigninSuccess(success : success)
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func handelesigninSuccess(success : Bool){
        guard success else {
            return
        }
        let maintabbar = TabBarViewController()
        maintabbar.modalPresentationStyle = .fullScreen
        present(maintabbar, animated: true)
    }
}
