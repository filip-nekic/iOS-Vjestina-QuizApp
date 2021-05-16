//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by five on 05/05/2021.
//

import Foundation
import UIKit

class QuizResultViewController: UIViewController {
    
    var correctAnswers: Int
    var numOfQuestions: Int
    var quizId: Int
    
    init(correctAnswers: Int, numOfQuestions: Int, quizId: Int) {
        self.correctAnswers = correctAnswers
        self.numOfQuestions = numOfQuestions
        self.quizId = quizId
        super.init(nibName: nil, bundle: nil)
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildViews() {
        view.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)
        let score = UILabel()
        view.addSubview(score)
        score.text = "\(correctAnswers)/\(numOfQuestions)"
        score.textColor = .white
        score.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        score.textAlignment = .center
        score.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            score.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            score.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])
        
        let finish = UIButton()
        view.addSubview(finish)
        let finishAttributes :[NSAttributedString.Key:Any] = [
            .font : UIFont.systemFont(ofSize: 17.0, weight:UIFont.Weight.bold),
            .foregroundColor: UIColor.purple
        ]
        finish.setAttributedTitle(NSAttributedString(string: "Finish quiz", attributes: finishAttributes), for: .normal)
        finish.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        finish.layer.cornerRadius = 26.0
        finish.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
        finish.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            finish.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:  -50),
            finish.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            finish.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "iosquiz.herokuapp.com"
        urlComponents.path = "/api/result"
        guard let url = urlComponents.url else {return}
        var request = URLRequest(url: url)
        let userDefaults = UserDefaults.standard
        let userIdInt = Int(userDefaults.string(forKey: "user_id")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userDefaults.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        let resultData = ResultData(quiz_id: quizId, user_id: userIdInt!, time: 20.0, no_of_correct: correctAnswers)
        let data = try! JSONEncoder().encode(resultData)
        request.httpBody = data
        let networkService = NetworkService()
        networkService.executeUrlRequestNoResponse(request) { (result: Result<String, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
            }
        }
    }
    
    
    @objc func finishQuiz() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
