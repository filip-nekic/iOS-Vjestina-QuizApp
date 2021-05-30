import CoreData

struct Question: Codable {

    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answers
        case correctAnswer = "correct_answer"
        
    }

}

extension Question {

    init(with entity: CDQuestion) {
        id = Int(entity.id)
        question = entity.question
        answers = entity.answers as! [String]
        correctAnswer = Int(entity.correctAnswer)
    }

    func populate(_ entity: CDQuestion) {
        entity.id = Int16(id)
        entity.question = question
        entity.answers = answers as! NSObject
        entity.correctAnswer = Int16(correctAnswer)
    }

}
