enum QuizCategory: String, Codable {

    case sport = "SPORTS"
    case science = "SCIENCE"
    
    enum CodingKeys: String, CodingKey {
        case sport = "SPORT"
        case science = "SCIENCE"
    }

}
