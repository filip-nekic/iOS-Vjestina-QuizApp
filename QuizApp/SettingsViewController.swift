//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by five on 07/05/2021.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
     
    var username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        view.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)
        let usernameLabel = UILabel()
        view.addSubview(usernameLabel)
        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        let usernameName = UILabel()
        view.addSubview(usernameName)
        usernameName.text = self.username
        usernameName.textColor = .white
        usernameName.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.bold)
        
        let logOutButton = UIButton()
        view.addSubview(logOutButton)
        let logOutAttributes :[NSAttributedString.Key:Any] = [
            .font : UIFont.systemFont(ofSize: 17.0, weight:UIFont.Weight.bold),
            .foregroundColor: UIColor.purple
        ]
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        logOutButton.setAttributedTitle(NSAttributedString(string: "Log out", attributes: logOutAttributes), for: .normal)
        logOutButton.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logOutButton.layer.cornerRadius = 26.0
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            usernameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)

        ])
        
        usernameName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameName.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            usernameName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            usernameName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            logOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func logOut() {
        self.navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
    
}
