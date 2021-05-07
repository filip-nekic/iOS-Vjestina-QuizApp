//
//  QuizViewController.swift
//  QuizApp
//
//  Created by five on 05/05/2021.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    
    var quiz: Quiz;
    var currentQuestionIndex: Int!
    var questions: [Question]!
    var currentCorrectAnswer: Int!
    var currentAnswers: [String]!
    var quizQuestion: QuestionTrackerView!
    var correctAnswers: Int
    
    init(quiz: Quiz) {
        self.quiz = quiz
        questions = quiz.questions
        currentQuestionIndex = -1
        correctAnswers = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildViews()        
    }
    
    private func buildViews() {
        view.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)
        quizQuestion = QuestionTrackerView()
        view.addSubview(quizQuestion)
        
        quizQuestion.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizQuestion.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizQuestion.topAnchor.constraint(equalTo: view.topAnchor),
            quizQuestion.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            quizQuestion.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        nextQuestion()
        
        
    }
    
    
    @objc func changeQuestion(_  button: UIButton!) {
        let text = button.currentAttributedTitle
        let index = currentAnswers.firstIndex(of: text!.string)
        if(index == currentCorrectAnswer) {
            button.backgroundColor = .green
            correctAnswers += 1
        } else {
            button.backgroundColor = .red
            quizQuestion.buttons[currentCorrectAnswer].backgroundColor = .green
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.nextQuestion()
        }
        
    }
    
    
    func nextQuestion() {
        
        currentQuestionIndex += 1
      
        if(currentQuestionIndex >= questions.count) {
            self.navigationController?.pushViewController(QuizResultViewController(correctAnswers: correctAnswers,numOfQuestions: questions.count), animated: true)

            
        } else {
            let buttons = quizQuestion.buttons!
            let questionAsked = quizQuestion.questionAsked!
            currentAnswers = questions[currentQuestionIndex].answers
            currentCorrectAnswer = questions[currentQuestionIndex].correctAnswer
            var i = 0
            let buttonAttributes :[NSAttributedString.Key:Any] = [
                .font : UIFont.systemFont(ofSize: 17.0, weight:UIFont.Weight.bold),
                .foregroundColor: UIColor.white
            ]
            questionAsked.attributedText = NSAttributedString(string: questions[currentQuestionIndex].question, attributes: buttonAttributes)
            for button in buttons {
                button.backgroundColor =  UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.3)
                button.addTarget(self, action: #selector(changeQuestion), for: .touchUpInside)
                button.setAttributedTitle(NSAttributedString(string: questions[currentQuestionIndex].answers[i], attributes: buttonAttributes), for: .normal)
                i += 1
            }
        }
        
    }
    
    
    

    
}
