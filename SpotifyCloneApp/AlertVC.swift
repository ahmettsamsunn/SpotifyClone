//
//  AlertVC.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 20.07.2024.
//

import UIKit

class AlertVC: UIViewController {

    let containerView = UIView()
    let titlelabel = TitleLabel(textAligment: .center, fontSize: 20)
    let messagelabel = BodyLabel(textAligment: .center)
    let actionbutton = Button(backgroundcolor: .systemGreen, title: "Ok")
    var alerttitle : String?
    var message : String?
    var buttontitle : String?
    let padding : CGFloat = 20
    init(alerttitle: String, message: String,buttontitle : String ) {
        super.init(nibName: nil, bundle: nil)
        self.alerttitle = alerttitle
        self.message = message
        self.buttontitle  = buttontitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
       configureBodyLabel()
    }
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    func configureTitleLabel(){
        containerView.addSubview(titlelabel)
        titlelabel.text = alerttitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
            titlelabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            titlelabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            titlelabel.heightAnchor.constraint(equalToConstant: 28)
        
        ])
    }
    func configureActionButton(){
        containerView.addSubview(actionbutton)
        actionbutton.setTitle(buttontitle ?? "Ok", for: .normal)
        actionbutton.addTarget(self, action:#selector(dismissVC) , for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionbutton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionbutton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            actionbutton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            actionbutton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
   @objc func dismissVC(){
        dismiss(animated: true)
    }
    func configureBodyLabel(){
        containerView.addSubview(messagelabel)
        messagelabel.text = message ?? "unable to complete request"
        messagelabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            messagelabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 8),
            messagelabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            messagelabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            messagelabel.bottomAnchor.constraint(equalTo: actionbutton.topAnchor, constant: -12)
        ])
    }
}
