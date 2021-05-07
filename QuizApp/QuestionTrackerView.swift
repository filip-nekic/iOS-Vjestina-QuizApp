//
//  QuestionTrackerView.swift
//  QuizApp
//
//  Created by five on 05/05/2021.
//

import Foundation
import UIKit

class QuestionTrackerView: UIView {
    var buttons: [UIButton]!
    var questionAsked: UILabel!
    init() {
        super.init(frame: .zero)
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
    
          
        questionAsked = UILabel()
        questionAsked.textColor = .white
        questionAsked.lineBreakMode = .byWordWrapping
        questionAsked.numberOfLines = 4
        self.addSubview(questionAsked)
        questionAsked.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionAsked.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            questionAsked.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            questionAsked.widthAnchor.constraint(equalTo: self.widthAnchor),
            questionAsked.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        buttons = [UIButton]()
        
        for i in 0...3 {
            let answer = UIButton()
            answer.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.3)
            answer.layer.cornerRadius = 26.0
            let xx = 50 * i + i * 10
            buttons.append(answer)
            self.addSubview(answer)
            answer.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                answer.topAnchor.constraint(equalTo: questionAsked.bottomAnchor, constant: CGFloat(xx)),
                answer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                answer.widthAnchor.constraint(equalTo: self.widthAnchor, constant:  -20),
                answer.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
    }
    
    
    
}
