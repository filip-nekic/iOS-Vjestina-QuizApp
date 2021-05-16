//
//  ResultData.swift
//  QuizApp
//
//  Created by five on 16/05/2021.
//

import Foundation 


class ResultData: Codable {
    
    let quiz_id: Int
    let user_id: Int
    let time: Double
    let no_of_correct: Int
    
    init(quiz_id: Int, user_id: Int, time: Double, no_of_correct: Int) {
        self.quiz_id = quiz_id
        self.user_id = user_id
        self.time = time
        self.no_of_correct = no_of_correct
    }
    
}
