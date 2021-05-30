import CoreData

struct Quiz: Codable {

    let id: Int
    let title: String
    let description: String
    let category: QuizCategory
    let level: Int
    let imageUrl: String
    let questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case category
        case level
        case imageUrl = "image"
        case questions
        
    }

}

extension Quiz {

    init(with entity: CDQuiz) {
        id = Int(entity.id)
        title = entity.title
        description = entity.descriptionof
        category = entity.category as! QuizCategory
        level = Int(entity.level)
        imageUrl = entity.imageUrl
        questions = entity.questions as! [Question]
    }
    
    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.id = Int16(id)
        entity.category = category as! NSObject
        entity.imageUrl = imageUrl
        entity.level = Int16(level)
        for question in questions {
            let cdQuestion = CDQuestion(context: context)
            question.populate(cdQuestion)
            entity.questions = cdQuestion
        }
    
    }
}
