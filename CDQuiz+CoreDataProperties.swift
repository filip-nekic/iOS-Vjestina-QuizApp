//
//  CDQuiz+CoreDataProperties.swift
//  QuizApp
//
//  Created by five on 29/05/2021.
//
//

import Foundation
import CoreData


extension CDQuiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuiz> {
        return NSFetchRequest<CDQuiz>(entityName: "CDQuiz")
    }

    @NSManaged public var category: NSObject
    @NSManaged public var descriptionof: String
    @NSManaged public var id: Int16
    @NSManaged public var imageUrl: String
    @NSManaged public var level: Int16
    @NSManaged public var questions: NSObject
    @NSManaged public var title: String
    @NSManaged public var quiz_question: NSSet

}

// MARK: Generated accessors for quiz_question
extension CDQuiz {

    @objc(addQuiz_questionObject:)
    @NSManaged public func addToQuiz_question(_ value: CDQuestion)

    @objc(removeQuiz_questionObject:)
    @NSManaged public func removeFromQuiz_question(_ value: CDQuestion)

    @objc(addQuiz_question:)
    @NSManaged public func addToQuiz_question(_ values: NSSet)

    @objc(removeQuiz_question:)
    @NSManaged public func removeFromQuiz_question(_ values: NSSet)

}

extension CDQuiz : Identifiable {

}
