//
//  LoginViewController.swift
//  QuizApp
//
//  Created by five on 12/04/2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private var headerText: UILabel!
    private var usernameTextInput: UITextField!
    private var passwordTextInput: UITextField!
    private var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)

        headerText = UILabel()
        headerText.text = "PopQuiz"
        headerText.textColor = .white
        headerText.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
        headerText.textAlignment = .center

        
        let defaultTextAttributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.bold)
        ]
        let placeHolderAttr:[NSAttributedString.Key :Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        ]
        
        usernameTextInput = UITextField()
        let paddingForUsernameText = UIView(frame:CGRect(x:0, y:0, width: 20, height: usernameTextInput.frame.height))
        usernameTextInput.defaultTextAttributes = defaultTextAttributes
        usernameTextInput.attributedPlaceholder = NSAttributedString(string: "Email", attributes: placeHolderAttr)
        usernameTextInput.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        usernameTextInput.layer.cornerRadius = 26.0
        usernameTextInput.leftView = paddingForUsernameText
        usernameTextInput.leftViewMode = .always
        usernameTextInput.rightView = paddingForUsernameText
        usernameTextInput.rightViewMode = .always
        usernameTextInput.addTarget(self, action: #selector(textFieldBorder), for: .editingDidBegin)
        usernameTextInput.addTarget(self, action: #selector(textFieldBorder), for: .editingDidEnd)
        usernameTextInput.addTarget(self, action: #selector(loginButtonEnabler), for: .editingChanged)
        usernameTextInput.autocapitalizationType = .none
        
       

        passwordTextInput = UITextField()
        let paddingForPasswordText = UIView(frame:CGRect(x:0, y:0, width: 20, height: passwordTextInput.frame.height))
        passwordTextInput.defaultTextAttributes = defaultTextAttributes
        passwordTextInput.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeHolderAttr)
        passwordTextInput.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        passwordTextInput.layer.cornerRadius = 26.0
        passwordTextInput.isSecureTextEntry = true
        passwordTextInput.leftView = paddingForPasswordText
        passwordTextInput.leftViewMode = .always
        let imageView = UIButton()
        let image = UIImage(systemName: "eye")
        imageView.setImage(image, for: .normal)
        imageView.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        passwordTextInput.rightView = imageView
        passwordTextInput.rightViewMode = .always
        passwordTextInput.addTarget(self, action: #selector(textFieldBorder), for: .editingDidBegin)
        passwordTextInput.addTarget(self, action: #selector(textFieldBorder), for: .editingDidEnd)
        passwordTextInput.addTarget(self, action: #selector(loginButtonEnabler), for: .editingChanged)
        
        
        loginButton = UIButton()
        let loginAttributes :[NSAttributedString.Key:Any] = [
            .font : UIFont.systemFont(ofSize: 17.0, weight:UIFont.Weight.bold),
            .foregroundColor: UIColor.purple
        ]
        loginButton.setAttributedTitle(NSAttributedString(string: "Login", attributes: loginAttributes), for: .normal)
        loginButton.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        loginButton.layer.cornerRadius = 26.0
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        view.addSubview(headerText)
        view.addSubview(usernameTextInput)
        view.addSubview(passwordTextInput)
        view.addSubview(loginButton)
    }

    private func addConstraints() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerText.heightAnchor.constraint(equalToConstant: 100),
            headerText.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20 )
        ])

        usernameTextInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextInput.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 100),
            usernameTextInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameTextInput.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            usernameTextInput.heightAnchor.constraint(equalToConstant: 50)
            
        ])

        passwordTextInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextInput.topAnchor.constraint(equalTo: usernameTextInput.bottomAnchor, constant: 20),
            passwordTextInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextInput.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            passwordTextInput.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextInput.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func textFieldBorder(_  field: UITextField!) {
        if(field.isEditing == false) {
            field.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            field.layer.borderWidth = 0
        } else {
            field.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            field.layer.borderWidth = 2
        }
    }
    
    @objc func loginButtonEnabler() {
        if(passwordTextInput.hasText == true && usernameTextInput.hasText == true) {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        }
    }
    
    @objc func submit() {
        let log = DataService()
        let result = log.login(email: usernameTextInput.text!, password: passwordTextInput.text!)
        switch result {
        case .error(let number, let error):
            print("\(number) " + error)
        case .success:
            print("Username: " + usernameTextInput.text! + "\n" + "Password: " + passwordTextInput.text!)
        }
    }
    
    @objc func showPassword() {
        let text  = passwordTextInput.text
        passwordTextInput.isSecureTextEntry.toggle()
        passwordTextInput.reloadInputViews()
        passwordTextInput.text = text
    }
    
    

   
}
