//
//  ProfileViewController.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    private let tableview : UITableView = {
       let tableview = UITableView()
        tableview.isHidden = true
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    private var models = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdata()
       title = "Hello"
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
        view.backgroundColor = .systemBackground
    }
    
    private func fetchdata(){
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.updateui(with: success)
                case .failure(let failure):
                    self?.presentGFAlertOnMainThread(title: "Error", message: "Failed to load profile", buttontitle: "Ok")
                }
               
            }
           
        }

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    private func updateui( with model : UserProfile) {
        tableview.isHidden = false
        models.append("Full Name : \(model.display_name)")
        models.append("Email : \(model.email)")
        models.append("Country : \(model.country)")
        models.append("ID : \(model.id)")
        models.append("Plan : \(model.product)")
        createtableviewheader(with : model.images?.first?.url)
        
        tableview.reloadData()
    }
    private func createtableviewheader(with string : String?) {
        guard let urlstring = string,let url = URL(string: urlstring) else {
            return
        }
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: view.widht, height: view.widht/1.5))
        let imagesize : CGFloat = headerview.height/2
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: imagesize, height: imagesize))
        headerview.addSubview(imageview)
        imageview.center = headerview.center
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = imagesize/2
        imageview.sd_setImage(with: url)
        tableview.tableHeaderView = headerview
        print((url))
    }
}
extension ProfileViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    
    
}
